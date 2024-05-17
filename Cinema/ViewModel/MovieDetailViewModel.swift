//
//  MovieDetailViewModel.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation
import Combine

// ViewModel for managing the details of a movie.
class MovieDetailViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var sessions: [Session] = []

    // Initializes the ViewModel for a specific movie.
    init(movieID: String) {
        loadMovieDetails(forID: movieID)
    }

    // Loads the movie and its sessions based on the movie ID.
    private func loadMovieDetails(forID movieID: String) {
        // Fetch the movie details
        if let fetchedMovie = CinemaModelManager.shared.movie(forID: movieID) {
            self.movie = fetchedMovie

            // Update sessions if it's a ReleasedMovie
            if let releasedMovie = fetchedMovie as? ReleasedMovie {
                self.sessions = releasedMovie.sessions
            }
        }
    }
}

