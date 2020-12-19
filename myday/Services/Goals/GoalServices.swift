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
    static func getGoals(completion: @escaping (Result<GetGoalsResponse, Error>) -> Void) {
        FirestoreManager.sendFirestoreRequest(GetGoalsRequest(), GetGoalsResponse.self, completion: completion)
    }
}
