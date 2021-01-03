//
//  SplashControllerUITests.swift
//  mydayUITests
//
//  Created by Berat Cevik on 1/1/21.
//

import XCTest
@testable import myday

class SplashControllerUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchEnvironment.updateValue("YES", forKey: "ShouldStopAtSplash")
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app.terminate()
        app = nil
    }
    
    func testLogoImageView() {
        let imageView = app.images["splash_logo_image_view".localized]
        XCTAssert(imageView.exists)
    }
}
