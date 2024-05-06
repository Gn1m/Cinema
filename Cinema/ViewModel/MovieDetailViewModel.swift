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
        self.sessions = movie.sessions
    }

    func selectSession(byID sessionID: String) {
        self.selectedSession = sessions.first { $0.id == sessionID }
    }
}

