//
//  MovieListView.swift
//  The Movie List
//
//  Created by Mayank Patel on 26/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MoviesListView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    
    var title: String
    var movieListType: MovieListType
    
    var orientation: String = "horizontal"
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                NavigationLink(destination: ViewAllListView(orientation: orientation, movieListType: movieListType, title: title), label: {
                    Text("View All")
                        .font(.system(size: 15))
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                })
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(viewModel.items ?? [], id: \.id) { item in
                        NavigationLink(
                            destination: MovieDetailsView(item: item),
                            label: {
                                MovieItemView(item: item, orientation: orientation)
                            })
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
        }
        .onAppear() {
            viewModel.fetchData(movieListType: movieListType)
        }
    }
}

struct MovieItemView: View {
    var item: Movies
    var orientation: String = "horizontal"
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: "\(Constants.imagesBaseUrl)\((orientation == "horizontal" ? item.backdrop_path : item.poster_path) ?? "")"))
                .resizable()
                .scaledToFill()
                .frame(width: orientation == "horizontal" ? (UIScreen.main.bounds.width / 2) - 20 : UIScreen.main.bounds.width / 3 - 20, height: orientation == "horizontal" ? 120 : 180)
                .redacted(reason: item.poster_path == nil ? .placeholder : .init())
                .cornerRadius(8)
            
           
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title ?? "")
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .redacted(reason: item.title == nil ? .placeholder : .init())
                    
                    Text(item.overview ?? "")
                        .font(.system(size: 15))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                        .redacted(reason: item.overview == nil ? .placeholder : .init())
                }
               Spacer()
        }
        .frame(width: orientation == "horizontal" ? (UIScreen.main.bounds.width / 2) - 20 : (UIScreen.main.bounds.width / 3) - 20)
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(title: "TITLE", movieListType: MovieListType.trending)
    }
}

