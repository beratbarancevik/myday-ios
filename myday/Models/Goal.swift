//
//  Goal.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

struct Goal: Codable {
    // MARK: - Properties
    var id: String
    var userId: String
    var title: String?
    var target: Int?
    var achieved: Int?
    var color: String?
    var created: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case userId
        case title
        case target
        case achieved
        case color
        case created
    }
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        id = (try? container?.decode(String.self, forKey: CodingKeys.id)) ?? ""
        userId = (try? container?.decode(String.self, forKey: CodingKeys.userId)) ?? ""
        title = try? container?.decode(String.self, forKey: CodingKeys.title)
        target = try? container?.decode(Int.self, forKey: CodingKeys.target)
        achieved = try? container?.decode(Int.self, forKey: CodingKeys.achieved)
        color = try? container?.decode(String.self, forKey: CodingKeys.color)
        created = try? container?.decode(String.self, forKey: CodingKeys.created)
    }
    
    init(id: String? = nil, userId: String? = nil, title: String? = nil, target: Int? = nil, achieved: Int? = nil, color: String? = nil, created: String? = nil) {
        self.id = id ?? ""
        self.userId = userId ?? AuthenticationManager.shared.userId
        self.title = title
        self.target = target
        self.achieved = achieved
        self.color = color ?? "green"
        self.created = created
    }
    
    // MARK: - Functions
    mutating func incrementAchieved() {
        guard let target = target else { return }
        
        guard var achieved = achieved else {
            self.achieved = 1
            return
        }
        
        if achieved < target {
            achieved += 1
            self.achieved = achieved
        }
    }
}
