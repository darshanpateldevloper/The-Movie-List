//
//  Movies.swift
//  The Movie List
//
//  Created by Mayank Patel on 26/10/24.
//

import Foundation

struct Movies: Identifiable, Decodable {
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
}
