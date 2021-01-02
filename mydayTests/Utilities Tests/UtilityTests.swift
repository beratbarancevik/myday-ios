//
//  UtilityTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/2/21.
//

import XCTest
@testable import myday

class UtilityTests: XCTestCase {
    var sut: Utility!
    
    override func setUp() {
        super.setUp()
        sut = Utility.shared
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testAppVersion() {
        XCTAssertFalse(sut.appVersion.isEmpty)
    }
    
    func testDeviceSettingsUrl() {
        XCTAssertNotNil(sut.deviceSettings)
    }
}
