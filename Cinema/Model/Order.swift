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

    /// Computed property to provide a string summarizing the ticket details in the order.
    var ticketDetails: String {
        tickets.map { "\($0.type): \($0.quantity) x $\($0.price)" }.joined(separator: ", ")
    }

    /// Initializes a new order with all necessary details.
    /// - Parameters:
    ///   - movie: The movie for which tickets are being ordered.
    ///   - session: The session during which the movie will be shown.
    ///   - timeSlot: The specific time slot within the session.
    ///   - tickets: Array of tickets included in the order.
    ///   - status: Initial status of the order, defaults to `.preparing`.
    ///   - account: Optional account that made the order.
    init(movie: Movie, session: Session, timeSlot: TimeSlot, tickets: [Ticket], status: OrderStatus = .preparing, account: AccountModel? = nil) {
        self.id = Order.generateUniqueID()
        self.movie = movie
        self.session = session
        self.timeSlot = timeSlot
        self.tickets = tickets
        self.status = status
        self.account = account
    }

    /// Updates the status of the order.
    /// - Parameter newStatus: The new status to set for the order.
    func updateStatus(newStatus: OrderStatus) {
        self.status = newStatus
    }

    /// Generates a unique identifier for the order.
    /// - Returns: A unique string identifier.
    private static func generateUniqueID() -> String {
        return UUID().uuidString
    }

    /// Checks if two orders are the same based on their unique identifiers.
    static func == (lhs: Order, rhs: Order) -> Bool {
        lhs.id == rhs.id
    }

    /// Hash function for conforming to the Hashable protocol.
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
