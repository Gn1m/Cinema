// Ticket.swift
// Cinema
//
// Created by Ming Z on 5/5/2024.
//

import Foundation


enum TicketType: String, Hashable {
    case adult, child

    /// Provides the default price for each type of ticket.
    var defaultPrice: Double {
        switch self {
        case .adult:
            return 12.0  // Default price for adult tickets.
        case .child:
            return 8.0   // Default price for child tickets.
        }
    }
}

class Ticket: Identifiable, Hashable {
    let id = UUID() // Unique identifier for the ticket.
    let type: TicketType // Type of the ticket (adult or child).
    let quantity: Int // Number of tickets of this type.
    let price: Double // Price of the ticket.
    let seatID: String // Seat identifier associated with the ticket.

    init(type: TicketType, quantity: Int, price: Double? = nil, seatID: String) {
        self.type = type
        self.quantity = quantity
        self.price = price ?? type.defaultPrice // Use default price if not provided.
        self.seatID = seatID
    }

    // Hashable and Equatable

    
    static func == (lhs: Ticket, rhs: Ticket) -> Bool {
        lhs.id == rhs.id
    }

  
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    /// Creates a default adult ticket.
    static func defaultAdultTicket(seatID: String) -> Ticket {
        return Ticket(type: .adult, quantity: 1, seatID: seatID)
    }
    
    /// Creates a default child ticket.
    static func defaultChildTicket(seatID: String) -> Ticket {
        return Ticket(type: .child, quantity: 1, seatID: seatID)
    }
}
