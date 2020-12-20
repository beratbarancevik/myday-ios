//
//  GoalDetailViewModel.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class GoalDetailViewModel: BaseViewModel {
    // MARK: - Properties
    var goal: Goal
    
    init() {
        goal = Goal()
    }
    
    init(goal: Goal) {
        self.goal = goal
    }
}
