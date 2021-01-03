//
//  DeleteGoalRequestTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class DeleteGoalRequestTests: XCTestCase {
    var sut: DeleteGoalRequest!
    
    override func setUp() {
        super.setUp()
        sut = DeleteGoalRequest(goal: Goal(id: "aflskjsdfaksn", userId: "oaisdfkhasjfj", title: "Drink Water", target: 10, achieved: 4, color: "blue"))
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
