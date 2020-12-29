//
//  FirestoreManager.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Firebase
import FirebaseFirestoreSwift

class FirestoreManager {
    // MARK: - Properties
    static let db = Firestore.firestore()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Requests
    static func createDocument<Req: CreateRequest>(request: Req, completion: @escaping (Result<Void, Error>) -> Void) {
        var body = request.body
        body[FirestoreField.createdAt.rawValue] = FieldValue.serverTimestamp()
        body[FirestoreField.updatedAt.rawValue] = FieldValue.serverTimestamp()
        db.collection(request.collection.rawValue).addDocument(data: body) { error in
            if let error = error {
                completion(Result.failure(error))
                return
            }
            completion(Result.success(()))
        }
    }
    
    static func deleteDocument<Req: DeleteRequest>(request: Req, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection(request.collection.rawValue).document(request.id).delete { error in
            if let error = error {
                completion(Result.failure(error))
                return
            }
            completion(Result.success(()))
        }
    }
    
    static func getSingleDocument<Req: SingleGetRequest, Res>(_ request: Req, completion: @escaping (Result<Res, Error>) -> Void) {
        db.collection(request.collection.rawValue).document(request.id).getDocument { snapshot, error in
            if let error = error {
                completion(Result.failure(error))
                return
            }
            
            if let snapshot = snapshot {
                switch request.collection {
                case .user:
                    guard var user = try? snapshot.data(as: User.self) else {
                        completion(Result.failure(AuthError.userDoesNotExist))
                        return
                    }
                    user.id = snapshot.documentID
                    completion(Result.success(user as! Res))
                default:
                    completion(Result.failure(GenericError.default))
                }
            }
        }
    }
    
    static func getDocuments<Req: GetRequest, Res>(_ request: Req, completion: @escaping (Result<Res, Error>) -> Void) {
        db.collection(request.collection.rawValue).whereField(FirestoreField.userId.rawValue, isEqualTo: request.userId).getDocuments { snapshot, error in
            if let error = error {
                completion(Result.failure(error))
                return
            }
            
            if let snapshot = snapshot {
                switch request.collection {
                case .goal:
                    let goals = snapshot.documents.compactMap { querySnapshot -> Goal? in
                        var goal = try? querySnapshot.data(as: Goal.self)
                        goal?.id = querySnapshot.documentID
                        return goal
                    }
                    completion(Result.success(goals as! Res))
                default:
                    completion(Result.failure(GenericError.default))
                }
            }
        }
    }
    
    static func updateDocument<Req: UpdateRequest>(request: Req, completion: @escaping (Result<Void, Error>) -> Void) {
        var body = request.body
        body[FirestoreField.updatedAt.rawValue] = FieldValue.serverTimestamp()
        db.collection(request.collection.rawValue).document(request.id).setData(body, merge: true) { error in
            if let error = error {
                completion(Result.failure(error))
                return
            }
            completion(Result.success(()))
        }
    }
}

// MARK: - Collection
enum FirestoreCollection: String {
    case goal
    case user
}

// MARK: - Field
enum FirestoreField: String {
    case createdAt
    case updatedAt
    case userId
}
