//
//  GetUserRequest.swift
//  myday
//
//  Created by Berat Cevik on 12/29/20.
//

class GetUserRequest: SingleGetRequest {
    // MARK: - Properties
    var collection: FirestoreCollection
    var id: String
    
    // MARK: - Init
    init(id: String) {
        collection = .users
        self.id = id
    }
}
