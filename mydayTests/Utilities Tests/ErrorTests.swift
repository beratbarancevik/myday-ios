//
//  ErrorTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/2/21.
//

import XCTest
@testable import myday

class GenericErrorTests: XCTestCase {
    var sut: GenericError.Type!
    
    override func setUp() {
        super.setUp()
        sut = GenericError.self
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testErrorDescription() {
        sut.allCases.forEach {
            XCTAssertFalse($0.localizedDescription.isEmpty)
        }
    }
}

class AuthErrorTests: XCTestCase {
    var sut: AuthError.Type!
    
    override func setUp() {
        super.setUp()
        sut = AuthError.self
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testErrorDescription() {
        sut.allCases.forEach {
            XCTAssertFalse($0.localizedDescription.isEmpty)
        }
    }
}
