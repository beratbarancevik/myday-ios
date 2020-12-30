//
//  UserServices.swift
//  myday
//
//  Created by Berat Cevik on 12/29/20.
//

class UserServices {
    // MARK: - Init
    private init() {}
    
    // MARK: - Requests
    static func getUser(id: String, completion: @escaping (Result<GetUserResponse, Error>) -> Void) {
        FirestoreManager.getSingleDocument(GetUserRequest(id: id), completion: completion)
    }
    
    static func updateUser(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        FirestoreManager.updateDocument(request: UpdateUserRequest(user: user), completion: completion)
    }
}
