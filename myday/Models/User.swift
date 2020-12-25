//
//  User.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

struct User: Codable {
    // MARK: - Properties
    var id: String
    var name: String?
    var photoUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case photoUrl
    }
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        id = (try? container?.decode(String.self, forKey: CodingKeys.id)) ?? ""
        name = try? container?.decode(String.self, forKey: CodingKeys.name)
        photoUrl = try? container?.decode(String.self, forKey: CodingKeys.photoUrl)
    }
    
    init(id: String? = nil, name: String? = nil, photoUrl: String? = nil) {
        self.id = id ?? ""
        self.name = name
        self.photoUrl = photoUrl
    }
}
