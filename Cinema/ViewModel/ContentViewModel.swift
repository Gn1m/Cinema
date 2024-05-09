//
//  MovieListViewModel.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    private var hasLoadedMovies = false

    init() {
        if !hasLoadedMovies {
            loadMovies()
            hasLoadedMovies = true
        }
    }

    func loadMovies() {
        movies = SampleMoviesProvider.getSampleMovies()
    }
}
