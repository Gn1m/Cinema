//
//  MovieListViewModel.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var selectedMovies: [Movie] = []
    @Published var selectedCategory: MovieCategory = .nowShowing

    enum MovieCategory {
        case nowShowing, comingSoon
    }

    init() {
        updateSelectedMovies(category: selectedCategory)
    }

    func updateSelectedMovies(category: MovieCategory) {
        switch category {
        case .nowShowing:
            selectedMovies = CinemaModelManager.shared.getReleasedMovies
        case .comingSoon:
            selectedMovies = CinemaModelManager.shared.getComingSoonMovies
        }
        selectedCategory = category
    }
}
