//
//  Genre.swift
//  The Movie List
//
//  Created by Mayank Patel on 26/10/24.
//

import Foundation

struct Genre: Codable {
    var id: Int?
    var name: String?
    
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
}
