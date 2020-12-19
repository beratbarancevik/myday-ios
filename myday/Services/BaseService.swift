//
//  BaseService.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

protocol Request {
    var path: String { get }
    var method: Method { get }
    var query: String? { get }
}

protocol Response: Codable {
    associatedtype T
    var data: T { get }
}
