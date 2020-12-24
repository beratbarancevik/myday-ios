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
    case facebook
    case google
    case logo
    case profile
    case settings
    
    var image: UIImage {
        return UIImage(named: self.rawValue)!
    }
}
