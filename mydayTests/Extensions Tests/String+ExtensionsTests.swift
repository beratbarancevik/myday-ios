//
//  String+ExtensionsTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/2/21.
//

import XCTest
@testable import myday

class StringExtensionsTests: XCTestCase {
    var sut: String!
    
    override func setUp() {
        super.setUp()
        sut = "application_name"
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testLocalized() {
        XCTAssertEqual(sut.localized, "My Day")
    }
    
    func testFirstLetterCapitalized() {
        XCTAssertEqual(sut.firstLetterCapitalized, "Application_name")
    }
}
