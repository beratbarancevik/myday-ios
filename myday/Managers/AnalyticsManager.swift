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
        
        // Firebase
        Analytics.setUserID(userId)
        
        // Facebook
        AppEvents.userID = userId
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
    
    var name: String {
        return self.rawValue.lowercased()
    }
}

// MARK: - User Properties
enum AnalyticsUserProperties: String {
    case LOGGED_IN
    
    var name: String {
        return self.rawValue.lowercased()
    }
}
