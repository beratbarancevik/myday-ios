//
//  AuthenticationManager.swift
//  myday
//
//  Created by Berat Cevik on 12/20/20.
//

import FBSDKLoginKit
import Combine
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
    
    // MARK: - Init
    private init() {}
    
    deinit {
        removeAuthenticationListeners()
    }
    
    // MARK: - Auth Actions
    func setUpAuthentication() {
        registerAuthenticationListeners()
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
    
    
    
    // MARK: - Account Linking
    
    
    
    // MARK: - Log Out
    
}

// MARK: - Auth State
enum AuthState: CaseIterable {
    case unknown
    case anonymous
    case account
}

// MARK: - Auth Type
enum AuthType: String {
    case anonymous
    case apple
    case facebook
    case google
}
