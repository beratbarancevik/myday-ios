//
//  SettingsViewModel.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class SettingsViewModel: BaseViewModel {
    // MARK: - Properties
    var settings = [[SettingType]]()
    
    // MARK: - Init
    init() {
        settings = [
            [
                SettingType.rate
            ],
//            [
//                SettingType.share
//            ],
//            [
//                SettingType.feedback
//            ],
//            [
//                SettingType.privacy,
//                SettingType.terms
//            ]
        ]
        
        if AuthenticationManager.shared.authState == .account {
            settings.append([
                SettingType.logOut,
//                SettingType.myData,
//                SettingType.deleteAccount
            ])
        }
    }
}

enum SettingType: String, CaseIterable {
    case rate
    
    case share
    
    case feedback
    
    case privacy
    case terms
    
    case logOut
    case myData
    case deleteAccount
    
    var title: String {
        switch self {
        case .deleteAccount:
            return "Delete Account"
        case .feedback:
            return "Email"
        case .logOut:
            return "Log Out"
        case .myData:
            return "My Data"
        case .privacy:
            return "Privacy Policy"
        case .rate:
            return "Rate on App Store"
        case .share:
            return "Share"
        case .terms:
            return "Terms of Service"
        }
    }
    
    var icon: Image {
        switch self {
        case .deleteAccount:
            return .deleteAccount
        case .feedback:
            return .email
        case .logOut:
            return .logOut
        case .myData:
            return .myData
        case .privacy:
            return .privacy
        case .rate:
            return .rate
        case .share:
            return .share
        case .terms:
            return .terms
        }
    }
}
