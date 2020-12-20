//
//  Goal.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

struct Goal: Codable {
    // MARK: - Properties
    var id: String
    let title: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
    }
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        id = (try? container?.decode(String.self, forKey: CodingKeys.id)) ?? ""
        title = try? container?.decode(String.self, forKey: CodingKeys.title)
    }
    
    init(id: String? = nil, title: String? = nil) {
        self.id = id ?? ""
        self.title = title
    }
}
