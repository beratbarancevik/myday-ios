//
//  GoogleAuthManagerTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class GoogleAuthManagerTests: XCTestCase {
    var sut: GoogleAuthManager!
    
    override func setUp() {
        super.setUp()
        sut = GoogleAuthManager()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testHandleGoogleAuth() {
        // TODO: add test
        XCTAssertTrue(true)
    }
}
