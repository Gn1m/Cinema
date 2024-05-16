// ReleasedMovie.swift
// Cinema
//
// Created by Ming Z on 9/5/2024.
//

import Foundation

/// Represents a movie that has been released and includes session information.
class ReleasedMovie: Movie {
    private var _sessions: [Session] // Internal storage for the list of sessions associated with the movie.

    /// Initializes a new released movie with session details.
    /// - Parameters:
    ///   - id: Unique identifier for the movie.
    ///   - name: Name of the movie.
    ///   - description: Description of the movie.
    ///   - sessions: Array of session objects detailing when and where the movie is being shown.
    ///   - trailerLink: Optional URL for the movie's trailer.
    ///   - imageURL: Optional URL for the movie's image.
    init(id: String, name: String, description: String, sessions: [Session], trailerLink: URL? = nil, imageURL: URL? = nil) {
        self._sessions = sessions // Initializing sessions for the released movie.
        super.init(id: id, name: name, description: description, trailerLink: trailerLink, imageURL: imageURL)
    }

    /// Public accessors and mutators for the movie's sessions.
    var sessions: [Session] {
        get { _sessions }
        set { _sessions = newValue }
    }
}
