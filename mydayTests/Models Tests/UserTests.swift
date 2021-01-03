//
//  UserTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class UserTests: XCTestCase {
    var sut: User!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testInit() {
        let path = Bundle(for: UserTests.self).path(forResource: "user", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        sut = try! JSONDecoder().decode(User.self, from: data)
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.id, "ancsucuasnbjbasfj")
        XCTAssertEqual(sut.email, "bbcevik26@gmail.com")
        XCTAssertEqual(sut.name, "Berat Cevik")
        XCTAssertEqual(sut.username, "beratbarancevik")
        XCTAssertEqual(sut.photoUrl, "https://media-exp1.licdn.com/dms/image/C4D03AQG6GryHcF_uiA/profile-displayphoto-shrink_200_200/0/1567087822291?e=1615420800&v=beta&t=T-GAWVhBZNNcOLn9iqMokhGtS5z1dj7_ZOS7lHFQwxI")
        XCTAssertEqual(sut.authType, 1)
    }
}
