//
//  GetGoalsResponse.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class GetGoalsResponse: Response {
    // MARK: - Properties
    typealias T = [Goal]
    var data: [Goal]
}
