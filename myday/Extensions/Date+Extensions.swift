//
//  Date+Extensions.swift
//  myday
//
//  Created by Berat Cevik on 12/23/20.
//

// swiftlint:disable force_unwrapping

import Foundation

extension Date {
    // MARK: - Variables
    var yesterday: Date {
        return Date().dayBefore
    }
    var tomorrow: Date {
        return Date().dayAfter
    }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var calendarTitle: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        var dateText = dateFormatter.string(from: self)
        dateText += ", \(dayOfWeek)"
        return dateText
    }
    
    var dayOfWeek: String {
        let dayOfWeekNumber = Calendar.current.component(.weekday, from: self)
        if let dayOfWeek = DayOfWeek(rawValue: dayOfWeekNumber) {
            return dayOfWeek.name
        }
        return ""
    }
    
    var dayOfWeekInitial: String {
        let dayOfWeekNumber = Calendar.current.component(.weekday, from: self)
        if let dayOfWeek = DayOfWeek(rawValue: dayOfWeekNumber) {
            return dayOfWeek.initial.uppercased()
        }
        return ""
    }
    
    // MARK: - Functions
    func getLast(number days: Int) -> [Date] {
        var dates = [Date]()
        var lastAddedDate = Date().tomorrow
        for _ in 0..<days {
            dates.insert(lastAddedDate.dayBefore, at: 0)
            lastAddedDate = lastAddedDate.dayBefore
        }
        return dates
    }
    
    func dates(from startDate: Date) -> [Date] {
        var date = startDate
        var dates = [Date]()
        while date < self {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    func dates(from startDate: String, format: String = "dd/MM/yyyy") -> [Date] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard var date = dateFormatter.date(from: startDate) else { return [] }
        
        var dates = [Date]()
        while date < self {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    // MARK: - Static Functions
    static func datesBetween(startDate: Date, endDate: Date) -> [Date] {
        var date = startDate
        var dates = [Date]()
        while date < endDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}

enum DayOfWeek: Int {
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    case sunday = 7
    
    var name: String {
        switch self {
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        case .sunday:
            return "Sunday"
        }
    }
    
    var initial: String {
        switch self {
        case .monday:
            return "m"
        case .tuesday, .thursday:
            return "t"
        case .wednesday:
            return "w"
        case .friday:
            return "f"
        case .saturday, .sunday:
            return "s"
        }
    }
}
