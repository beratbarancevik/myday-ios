//
//  GoalDetailViewModel.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Combine

class GoalDetailViewModel: BaseViewModel {
    // MARK: - Properties
    var goal: Goal
    
    let didSaveSubject = PassthroughSubject<Bool, Error>()
    
    // MARK: - Init
    init() {
        goal = Goal()
    }
    
    init(goal: Goal) {
        self.goal = goal
    }
    
    // MARK: - Service Requests
    func saveSubscription() {
        goal.id.isEmpty ? createSubscription() : updateSubscription()
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
                self?.didSaveSubject.send(completion: Subscribers.Completion.failure(error))
            }
        }
    }
    
    func updateSubscription() {
        GoalServices.updateGoal(goal: goal) { [weak self] result in
            switch result {
            case .success:
                self?.didSaveSubject.send(true)
            case .failure(let error):
                self?.didSaveSubject.send(completion: Subscribers.Completion.failure(error))
            }
        }
    }
}

// MARK: - GoalDetail
enum GoalDetail: String, CaseIterable {
    case title
    
    var placeholder: String {
        switch self {
        case .title:
            return "Title"
        }
    }
}
