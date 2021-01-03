//
//  GoalServicesTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class GoalServicesTests: XCTestCase {
    var sut: GoalServices.Type!
    
    override func setUp() {
        super.setUp()
        sut = GoalServices.self
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testCreateGoal() {
        // TODO: add test
        XCTAssertTrue(true)
    }
}
