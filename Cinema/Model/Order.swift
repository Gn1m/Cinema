//
//  Order.swift
//  Cinema
//
//  Created by Ming Z on 6/5/2024.
//

import Foundation

class Order: Identifiable {
    let id: String
    let movie: Movie
    let session: Session
    let tickets: [Ticket]
    
    init(id: String = UUID().uuidString, movie: Movie, session: Session, tickets: [Ticket]) {
        self.id = id
        self.movie = movie
        self.session = session
        self.tickets = tickets
    }
}
