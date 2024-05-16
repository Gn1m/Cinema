// ReleasedMovie.swift
// Cinema
//
// Created by Ming Z on 9/5/2024.
//

import Foundation

// ReleasedMovie inherits from Movie and adds sessions information
class ReleasedMovie: Movie {
    private var _sessions: [Session]

    // Initializer with sessions as an additional parameter
    init(id: String, name: String, description: String, sessions: [Session], trailerLink: URL? = nil, imageURL: URL? = nil) {
        self._sessions = sessions
        super.init(id: id, name: name, description: description, trailerLink: trailerLink, imageURL: imageURL)
    }

    // Computed property for sessions
    var sessions: [Session] {
        get {
            return _sessions
        }
        set {
            _sessions = newValue
        }
    }
}
