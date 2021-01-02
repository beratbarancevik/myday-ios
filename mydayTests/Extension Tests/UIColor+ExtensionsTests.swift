//
//  UIColor+ExtensionsTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/2/21.
//

import XCTest
@testable import myday

class UIColorExtensionsTests: XCTestCase {
    var sut: UIColor!
    
    override func setUp() {
        super.setUp()
        sut = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testConvenienceInit() {
        XCTAssertEqual(sut, UIColor(255, 255, 255, 1))
    }
}
