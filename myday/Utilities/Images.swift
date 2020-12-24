//
//  Images.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

// swiftlint:disable force_unwrapping

import UIKit

enum Images: String, CaseIterable {
    case add
    case addLarge = "add-large"
    case calendar
    case logo
    case profile
    case settings
    
    var image: UIImage {
        return UIImage(named: self.rawValue)!
    }
}
