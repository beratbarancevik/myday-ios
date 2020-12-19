//
//  String+Extensions.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
