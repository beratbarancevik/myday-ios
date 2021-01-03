//
//  AppleAuthManager.swift
//  myday
//
//  Created by Berat Cevik on 12/28/20.
//

import AuthenticationServices
import CryptoKit
import Firebase

protocol AppleAuthManagerDelegate: AnyObject {
    func appleSignInDidCancel()
    func appleSignInDidSucceed()
    func appleSignInDidFail(with error: Error)
}

class AppleAuthManager: NSObject {
    // MARK: - Properties
    private var currentNonce: String?
    
    weak var delegate: AppleAuthManagerDelegate?
    
    // MARK: - Functions
    func handleAppleAuth() {
        let nonce = createRandomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

// MARK: - Private Functions
private extension AppleAuthManager {
    func createRandomNonceString() -> String {
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        let length = 32
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { [weak self] _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    self?.delegate?.appleSignInDidFail(with: GenericError.default)
                }
                return random
            }
            
            randoms.forEach {
                if length == 0 {
                    return
                }
                
                if $0 < charset.count {
                    result.append(charset[Int($0)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap { return String(format: "%02x", $0) }.joined()
        return hashString
    }
    
    func handleFirebaseAuth(with appleIDCredential: ASAuthorizationAppleIDCredential) {
        guard let nonce = currentNonce, let appleIDToken = appleIDCredential.identityToken, let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            delegate?.appleSignInDidFail(with: GenericError.default)
            return
        }
        
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
        AuthenticationManager.shared.authenticate(with: credential, authType: .apple, shouldDirectAppleSignIn: appleIDCredential.email?.isEmpty ?? true) { [weak self] error in
            if let error = error {
                self?.delegate?.appleSignInDidFail(with: error)
                return
            }
            
            self?.delegate?.appleSignInDidSucceed()
        }
    }
}

// MARK: - ASAuthorizationControllerDelegate
extension AppleAuthManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            handleFirebaseAuth(with: appleIDCredential)
        default:
            delegate?.appleSignInDidFail(with: GenericError.default)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        if let error = error as? ASAuthorizationError {
            switch error.code {
            case .canceled:
                delegate?.appleSignInDidCancel()
            default:
                delegate?.appleSignInDidFail(with: error)
            }
        }
    }
}
