//
//  MovieDetailViewModel.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation
import Combine

// ViewModel for managing movie details
class MovieDetailViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var sessions: [Session] = []

    // Initializer to set up the movie and its sessions
    init(movieID: String) {
        self.movie = CinemaModelManager.shared.movie(forID: movieID)
        if let releasedMovie = movie as? ReleasedMovie {
            self.sessions = releasedMovie.sessions
        }
    }
}
