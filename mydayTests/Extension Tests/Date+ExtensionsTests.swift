//
//  Date+ExtensionsTests.swift
//  mydayTests
//
//  Created by Berat Cevik on 1/2/21.
//

import XCTest
@testable import myday

class DateExtensionsTests: XCTestCase {
    var sut: Date!
    
    override func setUp() {
        super.setUp()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        sut = dateFormatter.date(from: "01/01/2021")
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testYesterday() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date1 = Calendar.current.component(.day, from: Date.yesterday)
        let date2 = Calendar.current.component(.day, from: Date().dayBefore)
        XCTAssertEqual(date1, date2)
    }
    
    func testTomorrow() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date1 = Calendar.current.component(.day, from: Date.tomorrow)
        let date2 = Calendar.current.component(.day, from: Date().dayAfter)
        XCTAssertEqual(date1, date2)
    }
    
    func testDayBefore() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date1 = Calendar.current.component(.day, from: sut.dayBefore)
        let date2 = Calendar.current.component(.day, from: dateFormatter.date(from: "31/12/2020")!)
        XCTAssertEqual(date1, date2)
    }
    
    func testAfter() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date1 = Calendar.current.component(.day, from: sut.dayAfter)
        let date2 = Calendar.current.component(.day, from: dateFormatter.date(from: "02/01/2021")!)
        XCTAssertEqual(date1, date2)
    }
    
    func testDay() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        XCTAssertEqual(sut.day, 1)
    }
    
    func testCalendarTitle() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: "02/01/2021")!
        XCTAssertEqual(date.calendarTitle, "Jan 2, Sunday")
    }
    
    func testDayOfWeek() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: "02/01/2021")!
        XCTAssertEqual(date.dayOfWeek, "Sunday")
    }
    
    func testDayOfWeekInitial() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: "02/01/2021")!
        XCTAssertEqual(date.dayOfWeekInitial, "S")
    }
    
    func testDatesFromDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let startDate = dateFormatter.date(from: "31/12/2020")!
        let dates = sut.dates(from: startDate)
        XCTAssertEqual(dates.count, 1)
    }
    
    func testDatesFromString() {
        let dates = sut.dates(from: "31/12/2020")
        XCTAssertEqual(dates.count, 1)
    }
    
    func testGetLast() {
        let dates = Date.getLast(number: 3)
        let date0 = Calendar.current.component(.day, from: Date())
        let date1 = Calendar.current.component(.day, from: dates.last!)
        let date2 = Calendar.current.component(.day, from: dates.first!)
        let date3 = Calendar.current.component(.day, from: Date().dayBefore.dayBefore)
        XCTAssertEqual(date1, date0)
        XCTAssertEqual(date2, date3)
    }
    
    func testDatesBetween() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let endDate = dateFormatter.date(from: "10/01/2021")!
        let datesBetween = Date.datesBetween(startDate: sut, endDate: endDate)
        XCTAssertEqual(datesBetween.count, 9)
    }
}

class DayOfWeekTests: XCTestCase {
    var sut: DayOfWeek.Type!
    
    override func setUp() {
        super.setUp()
        sut = DayOfWeek.self
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testName() {
        sut.allCases.forEach {
            XCTAssertTrue(!$0.name.isEmpty)
        }
    }
    
    func testInitial() {
        sut.allCases.forEach {
            let initialLetter = $0.name.first!
            let initialString = String(initialLetter)
            XCTAssertEqual($0.initial, initialString.lowercased())
        }
    }
}
