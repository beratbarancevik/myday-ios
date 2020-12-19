//
//  CreateGoalRequest.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class CreateGoalRequest: CreateRequest {
    // MARK: - Properties
    var collection: FirestoreCollection
    var body: [String: Any]
    
    // MARK: - Init
    init(goal: Goal) {
        collection = .goals
        body = goal.dictionary ?? [:]
    }
}
