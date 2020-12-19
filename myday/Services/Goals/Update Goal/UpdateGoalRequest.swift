//
//  UpdateGoalRequest.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class UpdateGoalRequest: UpdateRequest {
    // MARK: - Properties
    var collection: FirestoreCollection
    var id: String
    var body: [String: Any]
    
    // MARK: - Init
    init(goal: Goal) {
        collection = .goals
        id = goal.id
        body = goal.dictionary ?? [:]
    }
}
