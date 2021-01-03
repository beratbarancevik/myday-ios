//
//  Notification+ExtensionsTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/2/21.
//

import XCTest
@testable import myday

class NotificationExtensionsTests: XCTestCase {
    var sut: NotificationCenter!
    
    override func setUp() {
        super.setUp()
        sut = NotificationCenter.default
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testNotificationNames() {
        // TODO: add tests
    }
}
