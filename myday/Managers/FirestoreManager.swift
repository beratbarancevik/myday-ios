//
//  FirestoreManager.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Firebase

class FirestoreManager {
    // MARK: - Properties
    static let db = Firestore.firestore()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Firestore Request
    static func sendFirestoreRequest<Req: Request, Res: Response>(_ request: Req, _ responseType: Res.Type, completion: @escaping (Result<Res, Error>) -> Void) {
        switch request.method {
        case .get:
            getDocuments(request, responseType, completion: completion)
        default:
            break
        }
    }
    
    // MARK: - Firestore Queries
    static func getDocuments<Req: Request, Res: Response>(_ request: Req, _ responseType: Res.Type, completion: @escaping (Result<Res, Error>) -> Void) {
        db.collection(request.path).getDocuments() { snapshot, error in
            if let error = error {
                completion(Result.failure(error))
            } else {
                for document in snapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}

// MARK: - Method
enum Method: String {
    case get
    case post
    case put
    case delete
}
