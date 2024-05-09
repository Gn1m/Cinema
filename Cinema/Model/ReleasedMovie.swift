//
//  ReleasedMovie.swift
//  Cinema
//
//  Created by Ming Z on 9/5/2024.
//
import Foundation


// ReleasedMovie subclass, with additional properties for sessions
class ReleasedMovie: Movie {
    private var _sessions: [Session]

    // Initialiser includes the additional sessions property
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
