//
//  GoalServices.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class GoalServices {
    // MARK: - Init
    private init() {}
    
    // MARK: - Requests
    static func createGoal(goal: Goal, completion: @escaping (Result<Void, Error>) -> Void) {
        FirestoreManager.shared.createDocument(request: CreateGoalRequest(goal: goal), completion: completion)
    }
    
    static func deleteGoal(goal: Goal, completion: @escaping (Result<Void, Error>) -> Void) {
        FirestoreManager.shared.deleteDocument(request: DeleteGoalRequest(goal: goal), completion: completion)
    }
    
    static func getGoals(completion: @escaping (Result<GetGoalsResponse, Error>) -> Void) {
        FirestoreManager.shared.getDocuments(GetGoalsRequest(), completion: completion)
    }
    
    static func updateGoal(goal: Goal, completion: @escaping (Result<Void, Error>) -> Void) {
        FirestoreManager.shared.updateDocument(request: UpdateGoalRequest(goal: goal), completion: completion)
    }
}
