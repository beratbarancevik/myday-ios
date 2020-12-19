//
//  GetGoalsRequest.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class GetGoalsRequest: Request {
    // MARK: - Properties
    var path: String
    var method: Method
    var query: String?
    
    // MARK: - Init
    init() {
        path = FirestoreConstants.goals.rawValue
        method = .get
    }
}
