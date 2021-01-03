//
//  UserServicesTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class UserServicesTests: XCTestCase {
    var sut: UserServices.Type!
    
    override func setUp() {
        super.setUp()
        sut = UserServices.self
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testGetUser() {
        // TODO: add test
        XCTAssertTrue(true)
    }
}
