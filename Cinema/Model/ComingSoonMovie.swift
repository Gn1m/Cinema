// ComingSoonMovie.swift
// Cinema
//
// Created by Ming Z on 9/5/2024.
//

import Foundation

/// Represents a movie that is scheduled for future release, inheriting from the `Movie` class.
class ComingSoonMovie: Movie {
    /// Initializes a new movie that is coming soon.
    /// - Parameters:
    ///   - id: Unique identifier for the movie.
    ///   - name: Name of the movie.
    ///   - description: Description of the movie.
    ///   - trailerLink: Optional URL for the movie's trailer.
    ///   - imageURL: Optional URL for the movie's image.
    override init(id: String, name: String, description: String, trailerLink: URL? = nil, imageURL: URL? = nil) {
        super.init(id: id, name: name, description: description, trailerLink: trailerLink, imageURL: imageURL)
    }
}
