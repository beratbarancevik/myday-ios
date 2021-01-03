//
//  AppleAuthManagerTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class AppleAuthManagerTests: XCTestCase {
    var sut: AppleAuthManager!
    
    override func setUp() {
        super.setUp()
        sut = AppleAuthManager()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testHandleAuth() {
        // TODO: add test
        XCTAssertTrue(true)
    }
}
