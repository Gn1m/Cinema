// Movie.swift
// Cinema
//
// Created by Ming Z on 5/5/2024.
//

import Foundation

// Movie class represents a film with its basic information
class Movie: Identifiable, Hashable {
    private let _id: String
    private var _name: String
    private var _description: String
    private var _trailerLink: URL?
    private var _imageURL: URL?

    // Initializer with optional parameters for trailerLink and imageURL
    init(id: String, name: String, description: String, trailerLink: URL? = nil, imageURL: URL? = nil) {
        self._id = id
        self._name = name
        self._description = description
        self._trailerLink = trailerLink
        self._imageURL = imageURL
    }

    // Computed properties for encapsulating the private variables
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

    // Conforming to Hashable protocol
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs._id == rhs._id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(_id)
    }
}
