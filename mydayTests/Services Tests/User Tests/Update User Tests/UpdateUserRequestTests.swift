//
//  UpdateUserRequestTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class UpdateUserRequestTests: XCTestCase {
    var sut: UpdateUserRequest!
    
    override func setUp() {
        super.setUp()
        sut = UpdateUserRequest(
            user: User(
                id: "ancsucuasnbjbasfj",
                email: "bbcevik26@gmail.com",
                name: "Berat Cevik",
                username: "beratbarancevik",
                photoUrl: "https://media-exp1.licdn.com/dms/image/C4D03AQG6GryHcF_uiA/profile-displayphoto-shrink_200_200/0/1567087822291?e=1615420800&v=beta&t=T-GAWVhBZNNcOLn9iqMokhGtS5z1dj7_ZOS7lHFQwxI",
                authType: 1))
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
