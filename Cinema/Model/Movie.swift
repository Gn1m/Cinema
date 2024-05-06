//
//  Movie.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation

class Movie: Identifiable {
    private let _id: String
    private var _name: String
    private var _description: String
    private var _sessions: [Session]
    private var _trailerLink: URL?
    private var _imageURL: URL?

    init(id: String, name: String, description: String, sessions: [Session], trailerLink: URL? = nil, imageURL: URL? = nil) {
        self._id = id
        self._name = name
        self._description = description
        self._sessions = sessions
        self._trailerLink = trailerLink
        self._imageURL = imageURL
    }

    // 对外公开的属性
    var id: String {
        return _id
    }

    var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }

    var description: String {
        get {
            return _description
        }
        set {
            _description = newValue
        }
    }

    var sessions: [Session] {
        get {
            return _sessions
        }
        set {
            _sessions = newValue
        }
    }

    var trailerLink: URL? {
        get {
            return _trailerLink
        }
        set {
            _trailerLink = newValue
        }
    }

    var imageURL: URL? {
        get {
            return _imageURL
        }
        set {
            _imageURL = newValue
        }
    }
}
