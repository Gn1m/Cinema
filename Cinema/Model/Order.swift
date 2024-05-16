//
//  Order.swift
//  Cinema
//
//  Created by Ming Z on 6/5/2024.
//

import Foundation

/// Enumeration for order status
enum OrderStatus: String {
    case preparing = "Preparing"
    case cancelled = "Cancelled"
}

/// Model class representing an order
class Order: Identifiable, Hashable {
    let id: String
    let movie: Movie
    let session: Session
    let timeSlot: TimeSlot
    let tickets: [Ticket]
    var status: OrderStatus
    var account: AccountModel?

    /// Computed property to get ticket details as a string
    var ticketDetails: String {
        tickets.map { "\($0.type): \($0.quantity) x $\($0.price)" }.joined(separator: ", ")
    }

    /// Initializer for creating an order
    init(movie: Movie, session: Session, timeSlot: TimeSlot, tickets: [Ticket], status: OrderStatus = .preparing, account: AccountModel? = nil) {
        self.id = Order.generateUniqueID()
        self.movie = movie
        self.session = session
        self.timeSlot = timeSlot
        self.tickets = tickets
        self.status = status
        self.account = account
    }

    /// Method to update the order status
    func updateStatus(newStatus: OrderStatus) {
        self.status = newStatus
    }

    /// Method to generate a unique ID for the order
    private static func generateUniqueID() -> String {
        return UUID().uuidString
    }

    /// Equality operator for comparing orders
    static func == (lhs: Order, rhs: Order) -> Bool {
        lhs.id == rhs.id
    }

    /// Hash function for the order
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
