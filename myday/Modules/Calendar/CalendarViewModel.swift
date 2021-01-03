//
//  CalendarViewModel.swift
//  myday
//
//  Created by Berat Cevik on 12/23/20.
//

import Combine
import Foundation

class CalendarViewModel: BaseViewModel {
    // MARK: - Properties
    var dayViewModels = [DayViewModel]()
    
    // MARK: - Properties
    let loadingSubject = PassthroughSubject<Bool, Never>()
    let goalsSubject = PassthroughSubject<[Goal], Error>()
    
    var goals = [Goal]()
    
    // MARK: - Init
    init() {
        fetchDays()
    }
    
    // MARK: - Service Requests
    func getGoals() {
        loadingSubject.send(true)
        GoalServices.getGoals { [weak self] result in
            self?.loadingSubject.send(false)
            switch result {
            case .success(let response):
                self?.goals = response
                self?.goalsSubject.send(response)
            case .failure(let error):
                self?.goalsSubject.send(completion: Subscribers.Completion.failure(error))
            }
        }
    }
}

// MARK: - Private Functions
private extension CalendarViewModel {
    func fetchDays() {
        dayViewModels = Date().dates(from: "01/01/2021").map { DayViewModel(date: $0) }
        dayViewModels.last?.isSelected = true
    }
}
