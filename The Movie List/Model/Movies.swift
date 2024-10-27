//
//  Movies.swift
//  The Movie List
//
//  Created by Mayank Patel on 26/10/24.
//

import Foundation

struct Movies: Identifiable, Codable {
    var backdrop_path: String?
    var id: Int?
    var genres: [Genre]?
    var overview: String?
    var poster_path: String?
    var release_date: String?
    var runtime: Int?
    var status: String?
    var title: String?
    var original_language: String?
    var budget: Int?
    var revenue: Int?
    
    enum CodingKeys: CodingKey {
        case backdrop_path
        case id
        case genres
        case overview
        case poster_path
        case release_date
        case runtime
        case status
        case title
        case original_language
        case budget
        case revenue
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.backdrop_path = try container.decodeIfPresent(String.self, forKey: .backdrop_path)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.genres = try container.decodeIfPresent([Genre].self, forKey: .genres)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path)
        self.release_date = try container.decodeIfPresent(String.self, forKey: .release_date)
        self.runtime = try container.decodeIfPresent(Int.self, forKey: .runtime)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.original_language = try container.decodeIfPresent(String.self, forKey: .original_language)
        self.budget = try container.decodeIfPresent(Int.self, forKey: .budget)
        self.revenue = try container.decodeIfPresent(Int.self, forKey: .revenue)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.backdrop_path, forKey: .backdrop_path)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.genres, forKey: .genres)
        try container.encode(self.overview, forKey: .overview)
        try container.encode(self.poster_path, forKey: .poster_path)
        try container.encode(self.release_date, forKey: .release_date)
        try container.encode(self.runtime, forKey: .runtime)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.original_language, forKey: .original_language)
        try container.encode(self.budget, forKey: .budget)
        try container.encode(self.revenue, forKey: .revenue)
    }
}

struct Category: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String?
    var items: [Movies] = []
}
