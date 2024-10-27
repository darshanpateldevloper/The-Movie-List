//
//  HomeView.swift
//  The Movie List
//
//  Created by Mayank Patel on 26/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = CategoryViewModel()
    
    //MARK: - Custome Methods
    
    private func getTitle(string: String) -> MovieListType {
        switch string {
        case "Trending":
            return .trending
        case "Popular":
            return .popular
        case "Top Rated":
            return .topRated
        case "Upcoming":
            return .upcoming
        default:
            return .trending
        }
    }
    
    //MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    HStack() {
                        Text("Movies")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        Spacer()
                        
                        NavigationLink(destination: SearchMovieListView(), label: {
                            Image("icSearch")
                                .resizable()
                                .frame(width: 30,height: 30)
                        })
                    }
                    .padding()
                    Divider()
                        .frame(height: 1)
                        .background(.white)
                    ForEach(viewModel.items, id: \.id) { item in
                        MoviesListView(title: item.title ?? "", movieListType: self.getTitle(string: item.title ?? ""), item: item.items,orientation: item.title == "Trending" ? "horizontal" : "Vertical")
                    }
                    
                }
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            })
            .background(Color("background"))
            .navigationBarHidden(true)
           
        }
        .onAppear() {
            viewModel.fetchData(movieListType: .trending, completion: {_ in
                viewModel.fetchData(movieListType: .popular, completion: {_ in 
                    viewModel.fetchData(movieListType: .upcoming, completion: {_ in 
                        viewModel.fetchData(movieListType: .topRated, completion: {_ in 
                            
                        })
                    })
                })
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

