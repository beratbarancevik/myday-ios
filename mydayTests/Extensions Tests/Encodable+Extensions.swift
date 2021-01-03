//
//  Encodable+Extensions.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/2/21.
//

import XCTest
@testable import myday

class EncodableExtensionsTests: XCTestCase {
    var sut: Goal!
    
    override func setUp() {
        super.setUp()
        sut = Goal(id: "aflskjsdfaksn", userId: "oaisdfkhasjfj", title: "Drink Water", target: 10, achieved: 4, color: "blue")
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testDictionary() {
        let dictionary = sut.dictionary!
        XCTAssertEqual(dictionary["id"] as! String, "aflskjsdfaksn")
        XCTAssertEqual(dictionary["userId"] as! String, "oaisdfkhasjfj")
        XCTAssertEqual(dictionary["title"] as! String, "Drink Water")
        XCTAssertEqual(dictionary["target"] as! Int, 10)
        XCTAssertEqual(dictionary["achieved"] as! Int, 4)
        XCTAssertEqual(dictionary["color"] as! String, "blue")
    }
}
