//
//  AuthenticationManager.swift
//  myday
//
//  Created by Berat Cevik on 12/20/20.
//

import Combine
import FBSDKLoginKit
import Firebase
import GoogleSignIn

class AuthenticationManager {
    // MARK: - Properties
    static let shared = AuthenticationManager()
    
    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    let authDidCompleteSubject = PassthroughSubject<Bool, Never>()
    
    var authState: AuthState {
        guard let user = Auth.auth().currentUser else {
            return .unknown
        }
        return user.isAnonymous ? .anonymous : .account
    }
    
    var userId: String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    // MARK: - Init
    private init() {}
    
    deinit {
        removeAuthenticationListeners()
    }
    
    // MARK: - Setup
    func setUpAuthentication() {
        registerAuthenticationListeners()
    }
    
    // MARK: - Account Linking
    func authenticate(with credential: AuthCredential, authType: AuthType, shouldDirectAppleSignIn: Bool = false, completion: @escaping (Error?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(GenericError.default)
            return
        }
        
        if shouldDirectAppleSignIn {
            signIn(with: credential, authType: authType) { error in
                completion(error)
            }
            return
        }
        
        user.link(with: credential) { [weak self] authResult, error in
            if let error = error {
                let errorCode = AuthErrorCode(rawValue: error._code)
                switch errorCode {
                case .accountExistsWithDifferentCredential, .credentialAlreadyInUse, .emailAlreadyInUse: // login not sign up
                    print("\(authType.rawValue): signing in instead")
                    self?.signIn(with: credential, authType: authType) { error in
                        completion(error)
                    }
                default:
                    Crashlytics.crashlytics().record(error: error)
                    completion(error)
                }
            }
            
            if let user = authResult?.user {
                let user = User(id: user.uid, email: user.email, name: user.displayName, photoUrl: user.photoURL?.absoluteString, authType: authType.number)
                UserServices.updateUser(user: user) { result in
                    switch result {
                    case .success:
                        AnalyticsManager.shared.logAuthEvent(.SIGNED_UP, authType: authType)
                        
                        completion(nil)
                    case .failure(let error):
                        Crashlytics.crashlytics().record(error: error)
                        completion(error)
                    }
                }
            }
        }
    }
    
    // MARK: - Log Out
    func logUserOut() {
        do {
            try Auth.auth().signOut()
            LoginManager().logOut()
            GIDSignIn.sharedInstance()?.signOut()
            NotificationCenter.default.post(name: .didLogOut, object: nil)
        } catch {
            Crashlytics.crashlytics().record(error: error)
        }
    }
}

// MARK: - Private Functions
private extension AuthenticationManager {
    // MARK: - Auth Handlers
    func registerAuthenticationListeners() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            AnalyticsManager.shared.updateUserProperties()
            if let user = user {
                print("\nUser ID: \(user.uid)\nEmail: \(user.email ?? "No email found")\n")
                self?.authDidCompleteSubject.send(true)
            } else {
                print("\nSigning in anonymously\n")
                AuthenticationManager.shared.signInAnonymously()
            }
        }
    }
    
    func removeAuthenticationListeners() {
        if let handle = authStateDidChangeListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    // MARK: - Anonymous Auth
    func signInAnonymously() {
        Auth.auth().signInAnonymously { authResult, error in
            if let result = authResult {
                print("\nSigned in anonymously with user ID: \(result.user.uid)\n")
            }
            
            if let error = error {
                Crashlytics.crashlytics().record(error: error)
            }
        }
    }
    
    // MARK: - Sign In
    func signIn(with credential: AuthCredential, authType: AuthType, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("🍎 Sign in with credential (\(authType.rawValue)) error: \(error.localizedDescription)")
                Crashlytics.crashlytics().record(error: error)
                completion(error)
            }
            
            if authResult != nil {
                AnalyticsManager.shared.logAuthEvent(.LOGGED_IN, authType: authType)
                
                completion(nil)
            }
        }
    }
}

// MARK: - Auth State
enum AuthState: CaseIterable {
    case unknown
    case anonymous
    case account
}

// MARK: - Auth Type
enum AuthType: String, CaseIterable {
    case anonymous
    case apple
    case facebook
    case google
    
    var number: Int {
        switch self {
        case .anonymous:
            return 0
        case .apple:
            return 1
        case .facebook:
            return 2
        case .google:
            return 3
        }
    }
}
