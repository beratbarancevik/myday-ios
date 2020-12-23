//
//  Goal.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

struct Goal: Codable {
    // MARK: - Properties
    var id: String
    var title: String?
    var target: Int?
    var achieved: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case target
        case achieved
    }
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        id = (try? container?.decode(String.self, forKey: CodingKeys.id)) ?? ""
        title = try? container?.decode(String.self, forKey: CodingKeys.title)
        target = try? container?.decode(Int.self, forKey: CodingKeys.target)
        achieved = try? container?.decode(Int.self, forKey: CodingKeys.achieved)
    }
    
    init(id: String? = nil, title: String? = nil, target: Int? = nil, achieved: Int? = nil) {
        self.id = id ?? ""
        self.title = title
        self.target = target
        self.achieved = achieved
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
