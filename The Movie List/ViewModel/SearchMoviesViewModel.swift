//
//  SearchMoviesViewModel.swift
//  The Movie List
//
//  Created by Mayank Patel on 27/10/24.
//

import Foundation


class SearchMoviesViewModel: ObservableObject {
    @Published var movie: Movies?
    
    func fetchData(queryString: String) {
        
        guard let url = URL(string: "\(Constants.baseURl)/search/multi?query=\(queryString)&include_adult=false&language=en-US&page=1") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(Constants.headerToken, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                let result: Movies = try JSONDecoder().decode(Movies.self, from: data)
                DispatchQueue.main.async {
                    self.movie = result
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

