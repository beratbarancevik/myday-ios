//
//  GetUserRequestTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class GetUserRequestTests: XCTestCase {
    var sut: GetUserRequest!
    
    override func setUp() {
        super.setUp()
        sut = GetUserRequest(id: "akcnruaacasjdf")
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testInit() {
        // TODO: add test
        XCTAssertTrue(true)
    }
}
