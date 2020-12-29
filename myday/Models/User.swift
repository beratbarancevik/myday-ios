//
//  User.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

struct User: Codable {
    // MARK: - Properties
    var id: String
    var email: String?
    var name: String?
    var username: String?
    var photoUrl: String?
    var authType: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id = "userId"
        case email
        case name
        case username
        case photoUrl
        case authType
    }
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        id = (try? container?.decode(String.self, forKey: CodingKeys.id)) ?? ""
        email = (try? container?.decode(String.self, forKey: CodingKeys.email)) ?? ""
        name = try? container?.decode(String.self, forKey: CodingKeys.name)
        username = try? container?.decode(String.self, forKey: CodingKeys.username)
        photoUrl = try? container?.decode(String.self, forKey: CodingKeys.photoUrl)
        authType = try? container?.decode(Int.self, forKey: CodingKeys.authType)
    }
    
    init(id: String? = nil, email: String? = nil, name: String? = nil, username: String? = nil, photoUrl: String? = nil, authType: Int? = -1) {
        self.id = id ?? ""
        self.email = email
        self.name = name
        self.username = username
        self.photoUrl = photoUrl
        self.authType = authType
    }
}
