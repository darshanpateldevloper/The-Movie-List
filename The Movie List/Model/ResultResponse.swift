//
//  ResultResponse.swift
//  The Movie List
//
//  Created by Mayank Patel on 26/10/24.
//

import Foundation

struct ResultResponse: Decodable {
    var page: Int?
    var results: [Movies]?
    var totalResults: Int?
    var totalPages: Int?
}
