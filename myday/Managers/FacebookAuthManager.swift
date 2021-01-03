//
//  FacebookAuthManager.swift
//  myday
//
//  Created by Berat Cevik on 12/29/20.
//

import FBSDKLoginKit
import Firebase

protocol FacebookAuthManagerDelegate: AnyObject {
    func facebookSignInDidCancel()
    func facebookSignInDidSucceed()
    func facebookSignInDidFail(with error: Error)
}

class FacebookAuthManager {
    // MARK: - Properties
    let loginManager = LoginManager()
    
    weak var delegate: FacebookAuthManagerDelegate?
    
    // MARK: - Functions
    func handleFacebookAuth(from viewController: BaseViewController) {
        loginManager.logIn(permissions: ["publicProfile", "email"], from: viewController) { [weak self] result, error in
            if result?.isCancelled ?? false {
                self?.loginManager.logOut()
                self?.delegate?.facebookSignInDidCancel()
                return
            }
            
            if let error = error {
                self?.loginManager.logOut()
                self?.delegate?.facebookSignInDidFail(with: error)
            }
            
            if let result = result, result.grantedPermissions.contains("email") {
                self?.handleFirebaseAuth(with: result)
            } else {
                self?.loginManager.logOut()
                self?.delegate?.facebookSignInDidFail(with: AuthError.emailPermission)
            }
        }
    }
}

// MARK: - Private Functions
private extension FacebookAuthManager {
    func handleFirebaseAuth(with result: LoginManagerLoginResult) {
        if let accessToken = result.token?.tokenString {
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
            AuthenticationManager.shared.authenticate(with: credential, authType: .facebook) { [weak self] error in
                if let error = error {
                    self?.delegate?.facebookSignInDidFail(with: error)
                } else {
                    self?.delegate?.facebookSignInDidSucceed()
                }
            }
        } else {
            delegate?.facebookSignInDidFail(with: GenericError.default)
        }
    }
}
