//
//  HomeViewModel.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Combine
import Foundation

class HomeViewModel: BaseViewModel {
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
}

// MARK: - Private Functions
private extension HomeViewModel {
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didSaveGoal), name: .didSaveGoal, object: nil)
    }
    
    @objc func didSaveGoal() {
        getGoals()
    }
}
