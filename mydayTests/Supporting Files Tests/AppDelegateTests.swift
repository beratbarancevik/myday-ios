//
//  AppDelegateTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import Firebase
import XCTest
@testable import myday

class AppDelegateTests: XCTestCase {
    var sut: UIApplicationDelegate!
    
    override func setUp() {
        super.setUp()
        sut = UIApplication.shared.delegate
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testAppDidFinishLaunchingWithOptions() {
        XCTAssertNotNil(sut as? AppDelegate)
        
        // Firebase
        XCTAssertNotNil(FirebaseApp.app())
    }
}
