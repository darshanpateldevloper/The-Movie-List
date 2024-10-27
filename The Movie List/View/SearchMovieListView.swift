//
//  SearchMovieListView.swift
//  The Movie List
//
//  Created by Mayank Patel on 27/10/24.
//

import SwiftUI

struct SearchMovieListView: View {
    //MARK: - Variable
    
    @ObservedObject private var viewModel = HomeViewModel()
    private let flexibleVerticalColumn = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let flexibleHorizontalColumn = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var orientation: String = "horizontal"
    @Environment(\.presentationMode) var presentation
    @State private var searchText: String = ""
    
    //MARK: - Custom Methods
    
    func searchMovies(for searchText: String) {
        if !searchText.isEmpty {
            self.viewModel.fetchData(isSearch: true, searchText: searchText)
        } else {
            self.viewModel.items = []
        }
    }
    
    //MARK: - Body
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    HStack(spacing: 10) {
                        Button(action: {
                            presentation.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 26))
                                .foregroundColor(Color(.white))
                        })
                        
                        Text("Movies")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    SearchBar(text: $searchText, onTextChanged: searchMovies)
                    if !self.viewModel.items.isEmpty {
                        LazyVGrid(columns: self.orientation == "horizontal" ? flexibleHorizontalColumn : flexibleVerticalColumn, spacing: 8) {
                            ForEach(viewModel.items, id: \.id) { item in
                                NavigationLink(
                                    destination: MovieDetailsView(id: item.id ?? 0),
                                    label: {
                                        MovieItemView(item: item, orientation: orientation)
                                            .onAppear() {
                                                if viewModel.hasReachedEnd(of: item) && !viewModel.isFetching {
                                                    self.viewModel.fetchNextItem(isSearch: true,searchText: searchText)
                                                }
                                            }
                                    })
                            }
                        }
                    } else {
                        VStack(alignment:.center) {
                            Spacer()
                            Text("No Data Found")
                                .font(.system(size: 15))
                                .foregroundStyle(.white)
                            Spacer()
                        }
                    }
                }
            }
            .padding()
            .onAppear() {
                if viewModel.page == 1 {
                    viewModel.fetchData(isSearch: true,searchText: searchText)
                }
            }
        }
        .background(Color("background"))
        .navigationBarHidden(true)
    }
}

#Preview {
    SearchMovieListView()
}
