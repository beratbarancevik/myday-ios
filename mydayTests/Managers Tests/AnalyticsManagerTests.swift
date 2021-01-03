//
//  AnalyticsManagerTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class AnalyticsManagerTests: XCTestCase {
    var sut: AnalyticsManager!
    
    override func setUp() {
        super.setUp()
        sut = AnalyticsManager.shared
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testUpdateUserProperties() {
        // TODO: add test
        XCTAssertTrue(true)
    }
}
