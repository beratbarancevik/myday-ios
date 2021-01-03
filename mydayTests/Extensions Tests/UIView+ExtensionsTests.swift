//
//  UIView+ExtensionsTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/2/21.
//

import XCTest
@testable import myday

class UIViewExtensionsTests: XCTestCase {
    var sut: UIView!
    
    override func setUp() {
        super.setUp()
        sut = UIView()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testStyle() {
        sut.style(Theme.View.primary)
        XCTAssertEqual(sut.backgroundColor, .systemBackground)
    }
    
    func testSetHidden() {
        sut.setHidden(true)
        XCTAssertTrue(sut.isHidden)
    }
}
