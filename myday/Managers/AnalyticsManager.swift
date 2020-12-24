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
        AppEvents.setUserData(authState, forType: AppEvents.UserDataType(AnalyticsUserProperties.AUTH_STATE.rawValue))
    }
    
    // MARK: - Event Logging
    func logEvent(_ event: AnalyticsEvent) {
        // Firebase
        Analytics.logEvent(event.name, parameters: nil)
        
        // Facebook
        AppEvents.logEvent(AppEvents.Name(rawValue: event.name))
    }
}

// MARK: - Events
enum AnalyticsEvent: String {
    case APP_OPENED
    
    case CREATED_GOAL
    case COMPLETED_GOAL
    case UPDATED_GOAL
    case DELETED_GOAL
    
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
