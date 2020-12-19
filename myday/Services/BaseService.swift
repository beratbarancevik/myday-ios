//
//  BaseService.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

protocol Request {
    var collection: FirestoreCollection { get }
    var method: Method { get }
    var query: String? { get }
}
