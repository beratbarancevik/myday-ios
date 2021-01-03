//
//  ThemeTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/2/21.
//

import XCTest
@testable import myday

class FontTests: XCTestCase {
    var sut: Montserrat.Type!
    
    override func setUp() {
        super.setUp()
        sut = Montserrat.self
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testFont() {
        sut.allCases.forEach {
            XCTAssertNotNil($0.font)
        }
    }
}
