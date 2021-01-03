//
//  FacebookAuthManagerTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class FacebookAuthManagerTests: XCTestCase {
    var sut: FacebookAuthManager!
    
    override func setUp() {
        super.setUp()
        sut = FacebookAuthManager()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testHandleFacebookAuth() {
        // TODO: add test
        XCTAssertTrue(true)
    }
}
