//
//  GetGoalsRequest.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class GetGoalsRequest: GetRequest {
    // MARK: - Properties
    var collection: FirestoreCollection
    var userId: String
    
    // MARK: - Init
    init() {
        collection = .goals
        userId = AuthenticationManager.shared.userId
    }
}
