//
//  DayViewModel.swift
//  myday
//
//  Created by Berat Cevik on 12/28/20.
//

import Foundation

class DayViewModel: BaseViewModel {
    // MARK: - Properties
    let date: Date
    var isSelected: Bool
    
    var day: Int {
        return date.day
    }
    
    var dayText: String {
        return "\(date.day)"
    }
    
    var dayOfWeekInitial: String {
        return date.dayOfWeekInitial
    }
    
    // MARK: - Init
    init(date: Date, isSelected: Bool = false) {
        self.date = date
        self.isSelected = isSelected
    }
}
