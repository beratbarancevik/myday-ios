//
//  GetGoalsRequest.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class GetGoalsRequest: Request {
    // MARK: - Properties
    var collection: FirestoreCollection
    var method: Method
    var query: String?
    
    // MARK: - Init
    init() {
        collection = .goals
        method = .getAll
    }
}
