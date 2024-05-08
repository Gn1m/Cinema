//
//  MovieListView.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            MovieCardView(movie: movie)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("Movies")
        }
        .navigationBarBackButtonHidden(true)
    }
}

// 自定义电影卡片视图
struct MovieCardView: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            // 异步加载图片
            AsyncImage(url: movie.imageURL) { image in // 直接使用 `URL?` 类型的 `imageURL`
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 220)
                    .clipped()
            } placeholder: {
                // 使用占位符提供更好的用户体验
                Color.gray
                    .frame(width: 150, height: 220)
            }
            
            // 显示电影标题
            Text(movie.name)
                .font(.headline)
                .multilineTextAlignment(.center)
                .frame(width: 150)
                .padding(.top, 8)
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .padding(.vertical, 8)
        
    }
}

// MainView 的预览
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
