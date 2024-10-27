//
//  CategoryViewModel.swift
//  The Movie List
//
//  Created by Mayank Patel on 27/10/24.
//


import SwiftUI

class CategoryViewModel: ObservableObject {
    @Published var items: [Category] = []
    
    
    private func setOfflineData() {
        DispatchQueue.main.async {
            self.items = UserDefaults.standard.persistOfflineData ?? []
        }
    }
   
    func fetchData(movieListType: MovieListType = .trending, completion: @escaping ((Bool) -> Void)) {
       
        guard let url = URL(string: "\(Constants.baseURl)/movie/\(movieListType.rawValue)?language=en-US&page=1") else {return}
        
        var request = URLRequest(url:  url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(Constants.headerToken, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { 
                completion(false)
                self.setOfflineData()
                return
            }
            do {
                let result: ResultResponse = try JSONDecoder().decode(ResultResponse.self, from: data)
    
                debugPrint(url)
                debugPrint(result)
                DispatchQueue.main.async {
                    var category = Category()
                    category.title = movieListType == .popular ? "Popular" : movieListType == .trending ? "Trending" : movieListType == .topRated ? "Top Rated" : "Upcoming"
                    category.items = result.results ?? []
                    self.items.append(category)
                    UserDefaults.standard.persistOfflineData = self.items
                    completion(true)
                }
            } catch {
                print(error)
                completion(false)
                self.setOfflineData()
            }
            
            if error != nil {
                do {
                    let res: ErrorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    print("Error while fetch data", res.status_message!)
                } catch {
                    print(error)
                }
                
                completion(false)
                self.setOfflineData()
            }
        }.resume()
    }
}

