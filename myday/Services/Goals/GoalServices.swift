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
    static func createGoal(goal: Goal, completion: @escaping (Result<CreateGoalResponse, Error>) -> Void) {
        FirestoreManager.createDocument(request: CreateGoalRequest(goal: goal), responseType: CreateGoalResponse.self, completion: completion)
    }
    
    static func deleteGoal(goal: Goal, completion: @escaping (Result<DeleteGoalResponse, Error>) -> Void) {
        FirestoreManager.deleteDocument(request: DeleteGoalRequest(goal: goal), responseType: DeleteGoalResponse.self, completion: completion)
    }
    
    static func getGoals(completion: @escaping (Result<GetGoalsResponse, Error>) -> Void) {
        FirestoreManager.getDocuments(GetGoalsRequest(), GetGoalsResponse.self, completion: completion)
    }
    
    static func updateGoal(goal: Goal, completion: @escaping (Result<UpdateGoalResponse, Error>) -> Void) {
        FirestoreManager.updateDocument(request: UpdateGoalRequest(goal: goal), responseType: UpdateGoalResponse.self, completion: completion)
    }
}
