// Ticket.swift
// Cinema
//
// Created by Ming Z on 5/5/2024.
//

import Foundation

// Enum representing ticket types
enum TicketType: String, Hashable {
    case adult, child
    
    // Default prices for each ticket type
    var defaultPrice: Double {
        switch self {
        case .adult:
            return 12.0
        case .child:
            return 8.0
        }
    }
}

// Ticket class represents a ticket for a movie session
class Ticket: Identifiable, Hashable {
    let id = UUID()
    let type: TicketType
    let quantity: Int
    let price: Double
    let seatID: String

    // Initializer for Ticket with optional price parameter
    init(type: TicketType, quantity: Int, price: Double? = nil, seatID: String) {
        self.type = type
        self.quantity = quantity
        self.price = price ?? type.defaultPrice
        self.seatID = seatID
    }

    // Conforming to Hashable protocol
    static func == (lhs: Ticket, rhs: Ticket) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Static methods to create default tickets
    static func defaultAdultTicket(seatID: String) -> Ticket {
        return Ticket(type: .adult, quantity: 1, seatID: seatID)
    }
    
    static func defaultChildTicket(seatID: String) -> Ticket {
        return Ticket(type: .child, quantity: 1, seatID: seatID)
    }
}
