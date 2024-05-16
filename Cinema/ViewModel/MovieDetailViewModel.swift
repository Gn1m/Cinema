//
//  MovieDetailViewModel.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation
import Combine

/// ViewModel for managing the details of a movie.
class MovieDetailViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var sessions: [Session] = []

    /// Initializes the ViewModel for a specific movie.
    /// - Parameter movieID: The identifier for the movie.
    init(movieID: String) {
        loadMovieDetails(forID: movieID)
    }

    /// Loads the movie and its sessions based on the movie ID.
    /// - Parameter movieID: The identifier of the movie to load.
    private func loadMovieDetails(forID movieID: String) {
        movie = CinemaModelManager.shared.movie(forID: movieID)
        updateSessionsForMovie()
    }

    /// Updates the sessions if the movie is already released.
    private func updateSessionsForMovie() {
        if let releasedMovie = movie as? ReleasedMovie {
            sessions = releasedMovie.sessions
        }
    }
}
