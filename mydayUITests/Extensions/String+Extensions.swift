//
//  String+Extensions.swift
//  mydayUITests
//
//  Created by Berat Cevik on 1/1/21.
//

import Foundation
@testable import myday

extension String {
    var localized: String {
        return NSLocalizedString(self, bundle: Bundle(for: SplashControllerUITests.self), comment: "")
    }
}
