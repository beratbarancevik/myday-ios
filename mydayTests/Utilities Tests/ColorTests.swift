//
//  ColorTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/2/21.
//

import XCTest
@testable import myday

class ColorTests: XCTestCase {
    var sut: Color.Type!
    
    override func setUp() {
        super.setUp()
        sut = Color.self
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testColors() {
        sut.allCases.forEach {
            XCTAssertNotNil($0.color)
        }
    }
}

class GoalColorTests: XCTestCase {
    var sut: GoalColor.Type!
    
    override func setUp() {
        super.setUp()
        sut = GoalColor.self
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testColors() {
        sut.allCases.forEach {
            XCTAssertNotNil($0.color)
        }
    }
    
    func testColorName() {
        XCTAssertEqual(sut.blue.name, "Blue")
    }
    
    func testColorLowercaseName() {
        XCTAssertEqual(sut.blue.lowercaseName, "blue")
    }
}
