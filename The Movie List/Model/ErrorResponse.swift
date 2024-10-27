//
//  ErrorResponse.swift
//  The Movie List
//
//  Created by Mayank Patel on 26/10/24.
//

import Foundation

struct ErrorResponse: Decodable {
    var status_message: String?
    var status_code: Int?
}
