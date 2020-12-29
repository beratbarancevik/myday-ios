//
//  BaseService.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

// MARK: - Root
protocol Request {
    var collection: FirestoreCollection { get }
}

protocol Response {}

// MARK: - Create
protocol CreateRequest: Request {
    var body: [String: Any] { get }
}

protocol CreateResponse: Response {}

// MARK: - Delete
protocol DeleteRequest: Request {
    var id: String { get }
}

protocol DeleteResponse: Response {}

// MARK: - Single Get
protocol SingleGetRequest: Request {
    var id: String { get }
}

protocol SingleGetResponse: Response {}

// MARK: - Get
protocol GetRequest: Request {}

protocol GetResponse: Response {}

// MARK: - Update
protocol UpdateRequest: Request {
    var id: String { get }
    var body: [String: Any] { get }
}

protocol UpdateResponse: Response {}
