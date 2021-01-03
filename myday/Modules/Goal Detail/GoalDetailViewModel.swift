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
            GoalDetail.color
        ],
        [
            GoalDetail.target,
            GoalDetail.achieved
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
            goal.id.isEmpty ? createGoal() : updateGoal()
        }
    }
}

// MARK: - Private Functions
private extension GoalDetailViewModel {
    func createGoal() {
        GoalServices.createGoal(goal: goal) { [weak self] result in
            switch result {
            case .success:
                self?.didSaveSubject.send(true)
            case .failure(let error):
                self?.didFailSubject.send(error)
            }
        }
    }
    
    func updateGoal() {
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
        
        if let achieved = goal.achieved {
            guard achieved <= goal.target ?? 0 else {
                didFailSubject.send(ValidationError.achievedMustBeSmaller)
                return false
            }
        }
        
        return true
    }
}

// MARK: - GoalDetail
enum GoalDetail: String, CaseIterable {
    case title
    case color
    case target
    case achieved
    
    var placeholder: String {
        switch self {
        case .title:
            return "Title"
        case .target:
            return "Target"
        case .achieved:
            return "Achieved"
        default:
            return ""
        }
    }
}

// MARK: - ValidationError
enum ValidationError: String, Error, LocalizedError {
    case achievedMustBeSmaller
    case enterTitle
    case enterValidTarget
    
    var errorDescription: String? {
        switch self {
        case .achievedMustBeSmaller:
            return "Achieved cannot be larger than target"
        case .enterTitle:
            return "Please enter a title"
        case .enterValidTarget:
            return "Target must be greater than 0"
        }
    }
}
