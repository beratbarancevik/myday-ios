//
//  GoalTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class GoalTests: XCTestCase {
    var sut: Goal!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testInit() {
        let path = Bundle(for: GoalTests.self).path(forResource: "goal", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        sut = try! JSONDecoder().decode(Goal.self, from: data)
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.id, "aflskjsdfaksn")
        XCTAssertEqual(sut.userId, "oaisdfkhasjfj")
        XCTAssertEqual(sut.title, "Drink Water")
        XCTAssertEqual(sut.target, 10)
        XCTAssertEqual(sut.achieved, 4)
        XCTAssertEqual(sut.color, "blue")
    }
}
