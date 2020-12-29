//
//  UpdateUserRequest.swift
//  myday
//
//  Created by Berat Cevik on 12/29/20.
//

class UpdateUserRequest: UpdateRequest {
    // MARK: - Properties
    var collection: FirestoreCollection
    var id: String
    var body: [String: Any]
    
    // MARK: - Init
    init(user: User) {
        collection = .user
        id = user.id
        body = user.dictionary ?? [:]
    }
}
