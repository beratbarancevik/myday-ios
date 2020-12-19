//
//  Goal.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

struct Goal: Codable {
    let title: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        title = try? container?.decode(String.self, forKey: CodingKeys.title)
    }
}
