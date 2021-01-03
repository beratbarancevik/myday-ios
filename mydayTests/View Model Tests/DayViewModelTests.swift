//
//  DayViewModelTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/3/21.
//

import XCTest
@testable import myday

class DayViewModelTests: XCTestCase {
    var sut: DayViewModel!
    
    override func setUp() {
        super.setUp()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        sut = DayViewModel(date: dateFormatter.date(from: "03/01/2021")!, isSelected: true)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testDay() {
        XCTAssertEqual(sut.day, 3)
    }
    
    func testDayText() {
        XCTAssertEqual(sut.dayText, "3")
    }
    
    func testDayOfWeek() {
        XCTAssertEqual(sut.dayOfWeekInitial, "M")
    }
    
    func testInit() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        XCTAssertEqual(sut.date, dateFormatter.date(from: "03/01/2021")!)
        XCTAssertTrue(sut.isSelected)
    }
}
