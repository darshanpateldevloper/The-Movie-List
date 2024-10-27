//
//  MovieDetailsView.swift
//  The Movie List
//
//  Created by Mayank Patel on 26/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailsView: View {
    
    //MARK: - Variable
    
    var id: Int = 0
    @StateObject private var viewModel = MovieDetailsViewModel()
    @Environment(\.presentationMode) var presentation
    
    //MARK: - Body
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(alignment: .leading) {
                WebImage(url: URL(string: "\(Constants.imagesBaseUrl)\(viewModel.movie?.poster_path ?? "")"))
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
                            
                            Text(viewModel.movie?.title ?? "")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            Text("\(viewModel.movie?.runtime ?? 0) min")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                
                            HStack(spacing: 8) {
                                ForEach(viewModel.movie?.genres ?? [], id: \.id) { genre in
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
            print("id", id)
            viewModel.fetchData(id: id)
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView()
    }
}

