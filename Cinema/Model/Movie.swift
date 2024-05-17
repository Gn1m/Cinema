// Movie.swift
// Cinema
//
// Created by Ming Z on 5/5/2024.
//

import Foundation


class Movie: Identifiable, Hashable {
    private let _id: String // Internal storage for movie's unique identifier.
    private var _name: String // Internal storage for movie's name.
    private var _description: String // Internal storage for movie's description.
    private var _trailerLink: URL? // Internal storage for movie's trailer URL, if available.
    private var _imageURL: URL? // Internal storage for movie's image URL, if available.
    
    init(id: String, name: String, description: String, trailerLink: URL? = nil, imageURL: URL? = nil) {
        self._id = id
        self._name = name
        self._description = description
        self._trailerLink = trailerLink
        self._imageURL = imageURL
    }


    // accessor for the movie's ID.
    var id: String {
        return _id
    }

    // accessors and mutators for the movie's name.
    var name: String {
        get { _name }
        set { _name = newValue }
    }

    //  accessors and mutators for the movie's description.
    var description: String {
        get { _description }
        set { _description = newValue }
    }

    // accessors and mutators for the movie's trailer link.
    var trailerLink: URL? {
        get { _trailerLink }
        set { _trailerLink = newValue }
    }

    // accessors and mutators for the movie's image URL.
    var imageURL: URL? {
        get { _imageURL }
        set { _imageURL = newValue }
    }

    // Hashable and Equatable

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs._id == rhs._id
    }

    
    func hash(into hasher: inout Hasher) {
        hasher.combine(_id)
    }
}
