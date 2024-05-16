// ComingSoonMovie.swift
// Cinema
//
// Created by Ming Z on 9/5/2024.
//

import Foundation

// ComingSoonMovie inherits from Movie with no additional properties or methods
class ComingSoonMovie: Movie {
    override init(id: String, name: String, description: String, trailerLink: URL? = nil, imageURL: URL? = nil) {
        super.init(id: id, name: name, description: description, trailerLink: trailerLink, imageURL: imageURL)
    }
}
