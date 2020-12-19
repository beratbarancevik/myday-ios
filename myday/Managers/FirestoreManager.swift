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
    
    var g: Goal?
    
    // MARK: - Firestore Request
    static func sendFirestoreRequest<Req: Request, Res>(_ request: Req, _ responseType: Res.Type, completion: @escaping (Result<Res, Error>) -> Void) {
        switch request.method {
        case .getAll:
            getDocuments(request, responseType, completion: completion)
        default:
            break
        }
    }
    
    // MARK: - Firestore Queries
    static func getDocuments<Req: Request, Res>(_ request: Req, _ responseType: Res.Type, completion: @escaping (Result<Res, Error>) -> Void) {
        db.collection(request.collection.rawValue).getDocuments() { snapshot, error in
            if let error = error {
                completion(Result.failure(error))
                return
            }
            
            if let snapshot = snapshot {
                switch request.collection {
                case .goals:
                    let goals = snapshot.documents.compactMap { querySnapshot -> Goal? in
                        return try? querySnapshot.data(as: Goal.self)
                    }
                    print("Golazo: \(goals.count)")
                    completion(Result.success(goals as! Res))
                }
            }
        }
    }
}

// MARK: - Method
enum Method: String {
    case getAll
    case post
    case put
    case delete
}

// MARK: - Collection
enum FirestoreCollection: String {
    case goals
}
