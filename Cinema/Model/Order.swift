//
//  Order.swift
//  Cinema
//
//  Created by Ming Z on 6/5/2024.
//

import Foundation

/// Enumeration defining possible statuses for an order.
enum OrderStatus: String {
    case preparing = "Preparing"  // Order is being prepared.
    case cancelled = "Cancelled"  // Order has been cancelled.
}

/// Represents a complete order for movie tickets.
class Order: Identifiable, Hashable {
    let id: String                  // Unique identifier for each order.
    let movie: Movie                // Movie associated with the order.
    let session: Session            // Session during which the movie will be shown.
    let timeSlot: TimeSlot          // Specific time slot of the session.
    let tickets: [Ticket]           // Array of tickets purchased in this order.
    var status: OrderStatus         // Current status of the order.
    var account: AccountModel?      // Optional account that made the order, nil if made by a guest.

    // provides a string summarising the ticket details in the order.
    var ticketDetails: String {
        tickets.map { "\($0.type): \($0.quantity) x $\($0.price)" }.joined(separator: ", ")
    }

    init(movie: Movie, session: Session, timeSlot: TimeSlot, tickets: [Ticket], status: OrderStatus = .preparing, account: AccountModel? = nil) {
        self.id = Order.generateUniqueID()
        self.movie = movie
        self.session = session
        self.timeSlot = timeSlot
        self.tickets = tickets
        self.status = status
        self.account = account
    }

    // Updates the status of the order.
    func updateStatus(newStatus: OrderStatus) {
        self.status = newStatus
    }

    // Generates a unique identifier for the order.
    private static func generateUniqueID() -> String {
        return UUID().uuidString
    }

    // Checks if two orders are the same based on their unique identifiers.
    static func == (lhs: Order, rhs: Order) -> Bool {
        lhs.id == rhs.id
    }

    // Hash function for conforming to the Hashable protocol.
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
