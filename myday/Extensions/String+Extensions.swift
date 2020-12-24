//
//  String+Extensions.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Foundation

extension String {
    // MARK: - Properties
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var firstLetterCapitalized: String {
        return self.capitalizingFirstLetter()
    }
}

// MARK: - Private Functions
private extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
