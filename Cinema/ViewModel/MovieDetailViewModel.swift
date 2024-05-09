//
//  MovieDetailViewModel.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    @Published var sessions: [Session] = []
    @Published var selectedSession: Session?

    private var movie: Movie

    init(movie: Movie) {
        self.movie = movie
        
        // Check if the movie is a ReleasedMovie to assign sessions
        if let releasedMovie = movie as? ReleasedMovie {
            self.sessions = releasedMovie.sessions
        } else {
            self.sessions = []
        }
    }

    func selectSession(byID sessionID: String) {
        self.selectedSession = sessions.first { $0.id == sessionID }
    }
}


