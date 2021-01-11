//
//  GoalsViewModel.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Combine
import Foundation

class GoalsViewModel: BaseViewModel {
    // MARK: - Properties
    let loadingSubject = PassthroughSubject<Bool, Never>()
    let goalsSubject = PassthroughSubject<[Goal], Error>()
    
    var goals = [Goal]()
    
    // MARK: - Init
    init() {
        addObservers()
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
    
    func updateGoal(goal: Goal) {
        GoalServices.updateGoal(goal: goal) { _ in }
    }
    
    func deleteGoal(at index: Int) {
        let goal = goals.remove(at: index)
        GoalServices.deleteGoal(goal: goal) { _ in }
        goalsSubject.send(goals)
    }
    
    // MARK: - Sorting
    func sort(by sortOption: SortOption) {
        switch sortOption {
        case .alphabeticAsc:
            goals.sort {
                guard let firstTitle = $0.title, let secondTitle = $1.title else {
                    return false
                }
                if firstTitle < secondTitle {
                    return true
                }
                return false
            }
        case .alphabeticDesc:
            goals.sort {
                guard let firstTitle = $0.title, let secondTitle = $1.title else {
                    return false
                }
                if firstTitle > secondTitle {
                    return true
                }
                return false
            }
        default:
            return
        }
        goalsSubject.send(goals)
    }
}

// MARK: - Private Functions
private extension GoalsViewModel {
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didSaveGoal), name: .didSaveGoal, object: nil)
    }
    
    @objc func didSaveGoal() {
        getGoals()
    }
}
