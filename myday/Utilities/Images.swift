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
    case logo
    
    var image: UIImage {
        return UIImage(named: self.rawValue)!
    }
}
