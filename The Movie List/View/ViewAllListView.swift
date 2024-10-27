//
//  ViewAllListView.swift
//  The Movie List
//
//  Created by Mayank Patel on 26/10/24.
//

import SwiftUI

struct ViewAllListView: View {
    
    //MARK: - Class Variable
    
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
    var movieListType: MovieListType
    @Environment(\.presentationMode) var presentation
    var title: String
    
    //MARK: - Body
    
    var body: some View {
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
                    
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                
                LazyVGrid(columns: self.orientation == "horizontal" ? flexibleHorizontalColumn : flexibleVerticalColumn, spacing: 8) {
                    ForEach(viewModel.items, id: \.id) { item in
                        NavigationLink(
                            destination: MovieDetailsView(item: item),
                            label: {
                                MovieItemView(item: item, orientation: orientation)
                                    .onAppear() {
                                        if viewModel.hasReachedEnd(of: item) && !viewModel.isFetching {
                                            self.viewModel.fetchNextItem(movieListType: movieListType)
                                        }
                                    }
                            })
                    }
                }
            }
        }
        .padding()
        .onAppear() {
            viewModel.fetchData(movieListType: movieListType)
        }
        .background(Color("background"))
        .navigationBarHidden(true)
    }
}

#Preview {
    ViewAllListView(movieListType: .trending, title: "")
}
