//
//  ReleasedMovie.swift
//  Cinema
//
//  Created by Ming Z on 9/5/2024.
//
import Foundation

class ReleasedMovie: Movie {
    private var _sessions: [Session]

    init(id: String, name: String, description: String, sessions: [Session], trailerLink: URL? = nil, imageURL: URL? = nil) {
        self._sessions = sessions
        super.init(id: id, name: name, description: description, trailerLink: trailerLink, imageURL: imageURL)
    }

    var sessions: [Session] {
        get {
            return _sessions
        }
        set {
            _sessions = newValue
        }
    }
}
