//
//  ContentViewModel.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.

import Foundation
import Combine

/// ViewModel for managing a list of movies.
class ContentViewModel: ObservableObject {
    @Published var selectedMovies: [Movie] = []
    @Published var selectedCategory: MovieCategory = .nowShowing

    /// Enum to categorize movies.
    enum MovieCategory {
        case nowShowing, comingSoon
    }

    /// Initializes the ViewModel by setting the initial movies list.
    init() {
        updateMoviesForSelectedCategory()
    }

    /// Updates the selected movies based on the current category.
    func updateMoviesForSelectedCategory() {
        selectedMovies = moviesForCategory(selectedCategory)
    }

    /// Retrieves movies based on the given category.
    /// - Parameter category: The category of movies to retrieve.
    /// - Returns: An array of movies corresponding to the category.
    private func moviesForCategory(_ category: MovieCategory) -> [Movie] {
        switch category {
        case .nowShowing:
            return CinemaModelManager.shared.getReleasedMovies
        case .comingSoon:
            return CinemaModelManager.shared.getComingSoonMovies
        }
    }
}
