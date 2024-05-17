// ReleasedMovie.swift
// Cinema
//
// Created by Ming Z on 9/5/2024.
//

import Foundation


class ReleasedMovie: Movie {
    private var _sessions: [Session] // Internal storage for the list of sessions associated with the movie.

  
    init(id: String, name: String, description: String, sessions: [Session], trailerLink: URL? = nil, imageURL: URL? = nil) {
        self._sessions = sessions // Initializing sessions for the released movie.
        super.init(id: id, name: name, description: description, trailerLink: trailerLink, imageURL: imageURL)
    }

    // accessors and mutators for the movie's sessions.
    var sessions: [Session] {
        get { _sessions }
        set { _sessions = newValue }
    }
}
