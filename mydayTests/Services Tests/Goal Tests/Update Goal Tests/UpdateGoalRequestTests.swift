//
//  UpdateGoalRequestTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class UpdateGoalRequestTests: XCTestCase {
    var sut: UpdateGoalRequest!
    
    override func setUp() {
        super.setUp()
        sut = UpdateGoalRequest(goal: Goal(id: "aflskjsdfaksn", userId: "oaisdfkhasjfj", title: "Drink Water", target: 10, achieved: 4, color: "blue"))
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
