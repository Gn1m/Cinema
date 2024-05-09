//
//  Movie.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation

// Base class Movie, contains shared properties
class Movie: Identifiable, Hashable {
    private let _id: String
    private var _name: String
    private var _description: String
    private var _trailerLink: URL?
    private var _imageURL: URL?
    
    // Initialiser for shared properties, including imageURL
    init(id: String, name: String, description: String, trailerLink: URL? = nil, imageURL: URL? = nil) {
        self._id = id
        self._name = name
        self._description = description
        self._trailerLink = trailerLink
        self._imageURL = imageURL
    }

    // Public properties for accessing private variables
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

    // Conform to Hashable protocol for usage in collections and navigation
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs._id == rhs._id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(_id)
    }
}
