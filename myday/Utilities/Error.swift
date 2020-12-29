//
//  Error.swift
//  myday
//
//  Created by Berat Cevik on 12/23/20.
//

import Foundation

// MARK: - Generic Error
enum GenericError: String, Error, LocalizedError {
    case `default`
    case internet
    
    var errorDescription: String? {
        switch self {
        case .default:
            return "An error occurred"
        case .internet:
            return "Check your internet connection"
        }
    }
}

// MARK: - Auth Error
enum AuthError: String, Error, LocalizedError {
    case emailPermission
    case userDoesNotExist
    
    var errorDescription: String? {
        switch self {
        case .emailPermission:
            return "Please give email permission"
        case .userDoesNotExist:
            return "User doesn't exist"
        }
    }
}
