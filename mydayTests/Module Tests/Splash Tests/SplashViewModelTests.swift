//
//  SplashViewModelTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/23/21.
//

import XCTest
@testable import myday

class SplashViewModelTests: XCTestCase {
    var sut: SplashViewModel!
    
    override func setUp() {
        super.setUp()
        sut = SplashViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
