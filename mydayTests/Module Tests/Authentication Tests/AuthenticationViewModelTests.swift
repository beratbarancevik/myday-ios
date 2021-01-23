//
//  AuthenticationViewModelTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/23/21.
//

import XCTest
@testable import myday

class AuthenticationViewModelTests: XCTestCase {
    var sut: AuthenticationViewModel!
    
    override func setUp() {
        super.setUp()
        sut = AuthenticationViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
