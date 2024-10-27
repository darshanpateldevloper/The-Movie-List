//
//  HomeViewModel.swift
//  The Movie List
//
//  Created by Mayank Patel on 26/10/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var items: [Movies]?
    
    //public var placeholders = Array(repeating: Movies(id: Int(UUID().uuidString), overview: nil, title: nil), count: 10)
    
    func fetchData(movieListType: MovieListType) {
        guard let url = URL(string: "\(Constants.baseURl)/movie/\(movieListType.rawValue)?language=en-US&page=1") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(Constants.headerToken, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let result: ResultResponse = try JSONDecoder().decode(ResultResponse.self, from: data)
                DispatchQueue.main.async {
                    self.items = result.results
                }
            } catch {
                print(error)
            }
            
            if error != nil {
                do {
                    let res: ErrorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    print("Error while fetch data", res.status_message!)
                    return
                } catch {
                    print(error)
                }
            }
            
            
        }.resume()
    }
}

enum MovieListType: String {
    case trending = "now_playing"
    case popular  = "popular"
    case upcoming = "upcoming"
    case topRated = "top_rated"
}
