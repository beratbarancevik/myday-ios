//
//  TabViewModelTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/23/21.
//

import XCTest
@testable import myday

class TabViewModelTests: XCTestCase {
    var sut: TabViewModel!
    
    override func setUp() {
        super.setUp()
        sut = TabViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}

