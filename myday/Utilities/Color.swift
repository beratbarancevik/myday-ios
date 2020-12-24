//
//  Color.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

// swiftlint:disable force_unwrapping

import UIKit

enum Color: String, CaseIterable {
    case apple
    case facebook
    case google
    
    var color: UIColor {
        return UIColor(named: self.rawValue)!
    }
}
