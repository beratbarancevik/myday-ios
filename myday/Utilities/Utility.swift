//
//  Utility.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

// swiftlint:disable force_unwrapping

import UIKit

class Utility {
    // MARK: - Properties
    static let shared = Utility()
    
    var appVersion: String {
        guard let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return "" }
        return currentVersion
    }
    
    var deviceSettings: URL {
        return URL(string: UIApplication.openSettingsURLString)!
    }
    
    // MARK: - Init
    private init() {}
}
