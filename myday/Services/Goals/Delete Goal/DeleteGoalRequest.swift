//
//  DeleteGoalRequest.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class DeleteGoalRequest: DeleteRequest {
    // MARK: - Properties
    var collection: FirestoreCollection
    var id: String
    
    // MARK: - Init
    init(goal: Goal) {
        collection = .goals
        id = goal.id
    }
}
