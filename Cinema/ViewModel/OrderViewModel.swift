//
//  OrderViewModel.swift
//  Cinema
//
//  Created by Ming Z on 6/5/2024.
//

import Foundation
import Combine

class OrderViewModel: ObservableObject {
    @Published private(set) var orders: [Order] = []
    
    // Add a new order to the list
    func addOrder(movie: Movie, session: Session, tickets: [Ticket]) {
        let newOrder = Order(movie: movie, session: session, tickets: tickets)
        orders.append(newOrder)
    }
    
    // Modify an existing order based on its id
    func updateOrder(id: String, newTickets: [Ticket]) {
        if let index = orders.firstIndex(where: { $0.id == id }) {
            orders[index] = Order(id: id, movie: orders[index].movie, session: orders[index].session, tickets: newTickets)
        }
    }

    // Remove an order by id
    func removeOrder(id: String) {
        orders.removeAll { $0.id == id }
    }
}

