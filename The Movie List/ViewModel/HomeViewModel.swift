//
//  HomeViewModel.swift
//  The Movie List
//
//  Created by Mayank Patel on 26/10/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var items: [Movies] = []
    private(set) var page = 1
    private(set) var totalPages: Int?
    @Published private(set) var viewState: ViewState?
    //public var placeholders = Array(repeating: Movies(id: Int(UUID().uuidString), overview: nil, title: nil), count: 10)
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }

    
    func hasReachedEnd(of item: Movies) -> Bool {
        items.last?.id == item.id
    }
    
    func fetchNextItem(movieListType: MovieListType = .trending,isSearch: Bool = false,searchText: String = "") {
        guard page != totalPages else { return }
        
        viewState = .fetching
        defer { viewState = .finished }
        
        page += 1
        
        self.fetchData(movieListType: movieListType,isSearch: isSearch,searchText: searchText)
    }
    
    func fetchData(movieListType: MovieListType = .trending,isSearch: Bool = false,searchText: String = "") {
        self.reset()
        self.viewState = .loading
        defer { self.viewState = .finished }
        
        guard let url = URL(string: "\(Constants.baseURl)/movie/\(movieListType.rawValue)?language=en-US&page=\(page)") else {return}
        
        guard let searchUrl = URL(string: "\(Constants.baseURl)/search/movie?query=\(searchText)&include_adult=false&language=en-US&page=\(page)") else {return}
        
        var request = URLRequest(url: isSearch ? searchUrl : url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(Constants.headerToken, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let result: ResultResponse = try JSONDecoder().decode(ResultResponse.self, from: data)
    
                debugPrint(isSearch ? searchUrl : url)
                debugPrint(result)
                DispatchQueue.main.async {
                    self.items.append(contentsOf: result.results ?? [])
                    self.totalPages = result.totalPages ?? 0
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

extension HomeViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}

private extension HomeViewModel {
    func reset() {
        if viewState == .finished {
            items.removeAll()
            page = 1
            totalPages = nil
            viewState = nil
        }
    }
}
