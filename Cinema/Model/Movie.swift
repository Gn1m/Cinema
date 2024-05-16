// Movie.swift
// Cinema
//
// Created by Ming Z on 5/5/2024.
//

import Foundation

/// Represents a movie with its essential details.
class Movie: Identifiable, Hashable {
    private let _id: String // Internal storage for movie's unique identifier.
    private var _name: String // Internal storage for movie's name.
    private var _description: String // Internal storage for movie's description.
    private var _trailerLink: URL? // Internal storage for movie's trailer URL, if available.
    private var _imageURL: URL? // Internal storage for movie's image URL, if available.

    /// Initializes a new movie with all necessary details.
    /// - Parameters:
    ///   - id: Unique identifier for the movie.
    ///   - name: Name of the movie.
    ///   - description: Description of the movie.
    ///   - trailerLink: Optional URL for the movie's trailer.
    ///   - imageURL: Optional URL for the movie's image.
    init(id: String, name: String, description: String, trailerLink: URL? = nil, imageURL: URL? = nil) {
        self._id = id
        self._name = name
        self._description = description
        self._trailerLink = trailerLink
        self._imageURL = imageURL
    }

    // MARK: - Public accessors and mutators for movie details

    /// Public accessor for the movie's ID.
    var id: String {
        return _id
    }

    /// Public accessors and mutators for the movie's name.
    var name: String {
        get { _name }
        set { _name = newValue }
    }

    /// Public accessors and mutators for the movie's description.
    var description: String {
        get { _description }
        set { _description = newValue }
    }

    /// Public accessors and mutators for the movie's trailer link.
    var trailerLink: URL? {
        get { _trailerLink }
        set { _trailerLink = newValue }
    }

    /// Public accessors and mutators for the movie's image URL.
    var imageURL: URL? {
        get { _imageURL }
        set { _imageURL = newValue }
    }

    // MARK: - Hashable and Equatable Conformance

    /// Compares two movies for equality based on their identifiers.
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs._id == rhs._id
    }

    /// Hashes the essential properties of the movie.
    func hash(into hasher: inout Hasher) {
        hasher.combine(_id)
    }
}
