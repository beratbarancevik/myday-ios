//
//  ImageTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/1/21.
//

import XCTest
@testable import myday

class ImageTests: XCTestCase {
    var sut: Image.Type!
    
    override func setUp() {
        super.setUp()
        sut = Image.self
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testImages() {
        Image.allCases.forEach {
            XCTAssertNotNil($0.image)
        }
    }
}
