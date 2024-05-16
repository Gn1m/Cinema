//
//  ContentViewModel.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.

import Foundation
import Combine

// ViewModel for managing movie list
class ContentViewModel: ObservableObject {
    @Published var selectedMovies: [Movie] = []
    @Published var selectedCategory: MovieCategory = .nowShowing

    // Enum to represent movie categories
    enum MovieCategory {
        case nowShowing, comingSoon
    }

    // Initializer to set up initial state
    init() {
        updateSelectedMovies(category: selectedCategory)
    }

    // Method to update the selected movies based on the category
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
