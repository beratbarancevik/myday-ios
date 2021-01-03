//
//  FirestoreManagerTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class FirestoreManagerTests: XCTestCase {
    var sut: FirestoreManager!
    
    override func setUp() {
        super.setUp()
        sut = FirestoreManager.shared
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testCreateDocument() {
        // TODO: add test
        XCTAssertTrue(true)
    }
}
