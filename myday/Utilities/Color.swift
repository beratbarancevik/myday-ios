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

enum GoalColor: String, CaseIterable {
    case blue
    case red
    case green
    case orange
    case indigo
    case pink
    case purple
    case teal
    case yellow
    
    var color: UIColor {
        switch self {
        case .blue:
            return .systemBlue
        case .red:
            return .systemRed
        case .green:
            return .systemGreen
        case .indigo:
            return .systemIndigo
        case .orange:
            return .systemOrange
        case .pink:
            return .systemPink
        case .purple:
            return .systemPurple
        case .teal:
            return .systemTeal
        case .yellow:
            return .systemYellow
        }
    }
    
    var name: String {
        return self.rawValue.firstLetterCapitalized
    }
}
