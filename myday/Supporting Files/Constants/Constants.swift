//
//  Constants.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

// swiftlint:disable duplicate_enum_cases

enum Constants {
    // URLs
    enum Urls: String, CaseIterable {
        case appStoreUrl = "https://apps.apple.com/us/app/my-day-track-goals/id1545759967"
        #if DEBUG
        case privacPolicyUrl = "https://myday-development.web.app/privacy.html"
        case termsOfServiceUrl = "https://myday-development.web.app/terms.html"
        #else
        case privacPolicyUrl = "https://myday-production.web.app/privacy.html"
        case termsOfServiceUrl = "https://myday-production.web.app/terms.html"
        #endif
    }
    
    // Email
    enum Emails: String, CaseIterable {
        case feedbackEmail = "bbcevik26@gmail.com"
    }
}
