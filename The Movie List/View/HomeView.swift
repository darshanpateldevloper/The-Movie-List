//
//  HomeView.swift
//  The Movie List
//
//  Created by Mayank Patel on 26/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    MoviesListView(title: "Trending", movieListType: MovieListType.trending)
                    
                    MoviesListView(title: "Popular", movieListType: MovieListType.popular,orientation: "vertical")
                    
                    MoviesListView(title: "Upcoming", movieListType: MovieListType.upcoming,orientation: "vertical")
                    
                    MoviesListView(title: "Top rated", movieListType: MovieListType.topRated,orientation: "vertical")
                    
                }
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            })
            .background(Color("background"))
            .navigationBarHidden(true)
           
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

