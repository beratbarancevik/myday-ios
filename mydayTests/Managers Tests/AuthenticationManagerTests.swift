//
//  AuthenticationManagerTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class AuthenticationManagerTests: XCTestCase {
    var sut: AuthenticationManager!
    
    override func setUp() {
        super.setUp()
        sut = AuthenticationManager.shared
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testAuthenticate() {
        // TODO: add test
        XCTAssertTrue(true)
    }
}

class AuthTypeTests: XCTestCase {
    var sut: AuthType.Type!
    
    override func setUp() {
        super.setUp()
        sut = AuthType.self
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testAuthTypes() {
        for (index, element) in sut.allCases.enumerated() {
            XCTAssertEqual(element.number, index)
        }
    }
}
