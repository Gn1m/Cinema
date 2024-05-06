//
//  MovieListViewModel.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation
import Combine

// 更新的 MainViewModel 示例
class MainViewModel: ObservableObject {
    @Published var movies: [Movie] = []

    init() {
        loadMovies()
    }

    func loadMovies() {
        // 更新样本电影数据
        self.movies = SampleMoviesProvider.getSampleMovies()
    }
}


