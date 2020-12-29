//
//  AnalyticsManager.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import FBSDKCoreKit
import Firebase

class AnalyticsManager {
    // MARK: - Properties
    static let shared = AnalyticsManager()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - User Properties
    func updateUserProperties() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let authState = AuthenticationManager.shared.authState == .account ? "account" : "anonymous"
        
        // Firebase
        Analytics.setUserID(userId)
        Analytics.setUserProperty(authState, forName: AnalyticsUserProperties.AUTH_STATE.rawValue)
        
        // Facebook
        AppEvents.userID = userId
    }
    
    // MARK: - Event Logging
    func logEvent(_ event: AnalyticsEvent, with parameters: [String: Any]? = nil) {
        // Firebase
        Analytics.logEvent(event.name, parameters: parameters)
        
        // Facebook
        AppEvents.logEvent(AppEvents.Name(rawValue: event.name))
    }
    
    func logAuthEvent(_ event: AnalyticsEvent, authType: AuthType) {
        let parameters = [
            "authType": authType.number
        ]
        
        // Firebase
        Analytics.logEvent(event.name, parameters: parameters)

        // Facebook
        AppEvents.logEvent(AppEvents.Name(rawValue: event.name))
    }
}

// MARK: - Events
enum AnalyticsEvent: String {
    case APP_OPENED
    
    case COMPLETED_GOAL
    case CREATED_GOAL
    case DELETED_GOAL
    case UPDATED_GOAL
    
    case LOGGED_IN
    case SIGNED_UP
    
    var name: String {
        return self.rawValue.lowercased()
    }
}

// MARK: - User Properties
enum AnalyticsUserProperties: String {
    case AUTH_STATE
    
    var name: String {
        return self.rawValue.lowercased()
    }
}
