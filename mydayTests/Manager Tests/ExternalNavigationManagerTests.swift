//
//  ExternalNavigationManagerTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class ExternalNavigationManagerTests: XCTestCase {
    var sut: ExternalNavigationManager!
    
    override func setUp() {
        super.setUp()
        sut = ExternalNavigationManager()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testOpenUrl() {
        // TODO: add test
        XCTAssertTrue(true)
    }
}
