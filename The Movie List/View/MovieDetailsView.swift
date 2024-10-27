//
//  MovieDetailsView.swift
//  The Movie List
//
//  Created by Mayank Patel on 26/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailsView: View {
    var item: Movies
    
    @ObservedObject private var viewModel = MovieDetailsViewModel()
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(alignment: .leading) {
                WebImage(url: URL(string: "\(Constants.imagesBaseUrl)\(item.poster_path ?? "")"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                    .clipped()
                    .overlay(
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Button(action: {
                                    presentation.wrappedValue.dismiss()
                                }, label: {
                                    Image(systemName: "arrow.left")
                                        .font(.system(size: 32))
                                        .foregroundColor(Color(.white))
                                })
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top, 40)
                            
                            Spacer()
                            
                            Text(item.title ?? "")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            Text("\(viewModel.movie?.runtime ?? 0) min")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                
                            HStack(spacing: 8) {
                                ForEach(viewModel.movie?.genres ?? [Genre(id: 0, name: nil)], id: \.id) { genre in
                                    Text(genre.name ?? "")
                                        .font(.system(size: 15))
                                        .foregroundColor(.gray)
                                    
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .foregroundColor(Color(.white))
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.124825187, green: 0.1294132769, blue: 0.1380611062, alpha: 1)), Color.clear]), startPoint: .bottom, endPoint: .top))
                    )
                
                VStack(alignment: .leading,spacing: 10) {
                    VStack(alignment: .leading,spacing: 5) {
                        Text("Release Date")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text(viewModel.movie?.release_date ?? "")
                            .font(.system(size: 15))
                            .foregroundStyle(.gray)
                    }
                    
                    VStack(alignment: .leading,spacing: 5) {
                        Text("Status")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text(viewModel.movie?.status ?? "")
                            .font(.system(size: 15))
                            .foregroundStyle(.gray)
                    }
                    
                    VStack(alignment: .leading,spacing: 5) {
                        Text("Budget")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("$ \(viewModel.movie?.budget ?? 0)")
                            .font(.system(size: 15))
                            .foregroundStyle(.gray)
                    }
                    
                    VStack(alignment: .leading,spacing: 5) {
                        Text("Revenue")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("$ \(viewModel.movie?.revenue ?? 0)")
                            .font(.system(size: 15))
                            .foregroundStyle(.gray)
                    }
                }
                .padding()
                Text(viewModel.movie?.overview ?? "")
                    .foregroundColor(.gray)
                    .padding()
                
                Spacer()
            }
        })
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .background(Color("background"))
        .ignoresSafeArea(.all, edges: .all)
        .onAppear {
            viewModel.fetchData(id: item.id!)
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(item: Movies(backdrop_path: "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg", id: 0, overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi auctor ligula dui, sit amet fermentum enim varius sed. Cras ultrices sodales ullamcorper. Nulla accumsan laoreet est in malesuada. Ut elementum condimentum rutrum. Pellentesque in mi in lorem congue placerat id euismod nisi. Donec at lacus sem. Curabitur tristique, mi in tincidunt sagittis, felis nisl tempor arcu, sit amet commodo arcu leo a nulla. Vivamus blandit diam sit amet nulla feugiat, at ultricies turpis mollis. Curabitur eleifend pulvinar ultricies. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus at sapien eros. Nunc vel facilisis neque.", poster_path: "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", release_date: "21-10-85", title: "The Awesome Movie"))
    }
}

