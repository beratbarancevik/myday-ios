//
//  Enums.swift
//  myday
//
//  Created by Berat Cevik on 12/23/20.
//

import Foundation

// MARK: - Generic Error
enum GenericError: String, Error, LocalizedError {
    case `default`
    
    var errorDescription: String? {
        switch self {
        case .default:
            return "An error occurred"
        }
    }
}
