//
//  ComingSoonMovie.swift
//  Cinema
//
//  Created by Ming Z on 9/5/2024.
//

import Foundation

// ComingSoonMovie subclass inherits from Movie, with only basic properties
class ComingSoonMovie: Movie {
    // No need for additional properties, uses base properties only
    override init(id: String, name: String, description: String, trailerLink: URL? = nil, imageURL: URL? = nil) {
        super.init(id: id, name: name, description: description, trailerLink: trailerLink, imageURL: imageURL)
    }
}
