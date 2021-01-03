//
//  GetGoalsRequestTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class GetGoalsRequestTests: XCTestCase {
    var sut: GetGoalsRequest!
    
    override func setUp() {
        super.setUp()
        sut = GetGoalsRequest()
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
