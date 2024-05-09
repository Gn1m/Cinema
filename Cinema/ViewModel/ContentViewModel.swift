//
//  MovieListViewModel.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var allMovies: [Movie] = []
    @Published var releasedMovies: [ReleasedMovie] = []
    @Published var comingSoonMovies: [ComingSoonMovie] = []
    @Published var selectedMovies: [Movie] = [] // Currently displayed movies
    @Published var selectedCategory: MovieCategory = .nowShowing

    private var hasLoadedMovies = false

    enum MovieCategory {
        case nowShowing, comingSoon
    }

    init() {
        if !hasLoadedMovies {
            loadMovies()
            hasLoadedMovies = true
        }
    }

    func loadMovies() {
        releasedMovies = SampleMoviesProvider.getReleasedMovies()
        comingSoonMovies = SampleMoviesProvider.getComingSoonMovies()
        updateSelectedMovies(category: selectedCategory)
    }

    func updateSelectedMovies(category: MovieCategory) {
        switch category {
        case .nowShowing:
            selectedMovies = releasedMovies
        case .comingSoon:
            selectedMovies = comingSoonMovies
        }
        selectedCategory = category
    }
}
