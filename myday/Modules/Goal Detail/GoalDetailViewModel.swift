//
//  GoalDetailViewModel.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Combine
import Foundation

class GoalDetailViewModel: BaseViewModel {
    // MARK: - Properties
    var goal: Goal
    
    let didSaveSubject = PassthroughSubject<Bool, Never>()
    let didFailSubject = PassthroughSubject<Error, Never>()
    
    let goalDetails = [
        [
            GoalDetail.title
        ],
        [
            GoalDetail.target
        ]
    ]
    
    // MARK: - Init
    init() {
        goal = Goal()
    }
    
    init(goal: Goal) {
        self.goal = goal
    }
    
    // MARK: - Service Requests
    func saveSubscription() {
        if isDataValid() {
            goal.id.isEmpty ? createSubscription() : updateSubscription()
        }
    }
}

// MARK: - Private Functions
private extension GoalDetailViewModel {
    func createSubscription() {
        GoalServices.createGoal(goal: goal) { [weak self] result in
            switch result {
            case .success:
                self?.didSaveSubject.send(true)
            case .failure(let error):
                self?.didFailSubject.send(error)
            }
        }
    }
    
    func updateSubscription() {
        GoalServices.updateGoal(goal: goal) { [weak self] result in
            switch result {
            case .success:
                self?.didSaveSubject.send(true)
            case .failure(let error):
                self?.didFailSubject.send(error)
            }
        }
    }
    
    func isDataValid() -> Bool {
        guard let title = goal.title, !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            didFailSubject.send(ValidationError.enterTitle)
            return false
        }
        
        if let target = goal.target {
            guard target > 0 else {
                didFailSubject.send(ValidationError.enterValidTarget)
                return false
            }
        }
        
        return true
    }
}

// MARK: - GoalDetail
enum GoalDetail: String, CaseIterable {
    case title
    case target
    
    var placeholder: String {
        switch self {
        case .title:
            return "Title"
        case .target:
            return "Target"
        }
    }
}

// MARK: - ValidationError
enum ValidationError: String, Error, LocalizedError {
    case enterTitle
    case enterValidTarget
    
    var errorDescription: String? {
        switch self {
        case .enterTitle:
            return "Please enter a title"
        case .enterValidTarget:
            return "Target must be greater than 0"
        }
    }
}
