//
//  GoogleAuthManager.swift
//  myday
//
//  Created by Berat Cevik on 12/29/20.
//

import Firebase
import GoogleSignIn

protocol GoogleAuthManagerDelegate: AnyObject {
    func googleSignInDidSucceed()
    func googleSignInDidFail(with error: Error)
}

class GoogleAuthManager: NSObject {
    // MARK: - Properties
    weak var delegate: GoogleAuthManagerDelegate?
    
    // MARK: Functions
    func handleGoogleAuth(from controller: BaseViewController) {
        AppDelegate.isGoogleSignIn = true
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().presentingViewController = controller
        GIDSignIn.sharedInstance().signIn()
    }
}

// MARK: - Private Functions
private extension GoogleAuthManager {
    func handleFirebaseAuth(with user: GIDGoogleUser) {
        guard let authentication = user.authentication else {
            delegate?.googleSignInDidFail(with: GenericError.default)
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        AuthenticationManager.shared.authenticate(with: credential, authType: .google) { [weak self] error in
            if let error = error {
                self?.delegate?.googleSignInDidFail(with: error)
                return
            }
            
            self?.delegate?.googleSignInDidSucceed()
        }
    }
}

// MARK: - GIDSignInDelegate
extension GoogleAuthManager: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("🍎 Google Sign In error: \(error.localizedDescription)")
            let errorCode = GIDSignInErrorCode(rawValue: error._code)
            switch errorCode {
            case .canceled?:
                return
            default:
                delegate?.googleSignInDidFail(with: error)
                return
            }
        }
        
        handleFirebaseAuth(with: user)
    }
}
