//
//  Image.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

// swiftlint:disable force_unwrapping

import UIKit

enum Image: String, CaseIterable {
    case add
    case addLarge = "add-large"
    case apple
    case calendar
    case deleteAccount = "delete-account"
    case email
    case facebook
    case google
    case logo
    case logOut = "log-out"
    case myData = "my-data"
    case privacy
    case profile
    case rate
    case settings
    case share
    case sort
    case terms
    
    var image: UIImage {
        return UIImage(named: self.rawValue)!
    }
}
