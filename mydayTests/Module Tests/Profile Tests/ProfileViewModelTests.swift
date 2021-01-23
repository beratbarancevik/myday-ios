//
//  ProfileViewModelTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/23/21.
//

import XCTest
@testable import myday

class ProfileViewModelTests: XCTestCase {
    var sut: ProfileViewModel!
    
    override func setUp() {
        super.setUp()
        sut = ProfileViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
