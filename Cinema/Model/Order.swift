//
//  Order.swift
//  Cinema
//
//  Created by Ming Z on 6/5/2024.
//

import Foundation

enum OrderStatus: String {
    case preparing = "Preparing"
    case cancelled = "Cancelled"
}


class Order: Identifiable, Hashable {
    let id: String
        let movie: Movie
        let session: Session
        let timeSlot: TimeSlot  
        let tickets: [Ticket]
        var status: OrderStatus

        

        var ticketDetails: String {
            tickets.map { "\($0.type): \($0.quantity) x $\($0.price)" }.joined(separator: ", ")
        }
        
    init(movie: Movie, session: Session, timeSlot: TimeSlot, tickets: [Ticket], status: OrderStatus = .preparing) {
            self.id = Order.generateUniqueID()
            self.movie = movie
            self.session = session
            self.timeSlot = timeSlot
            self.tickets = tickets
            self.status = status
        }
        
        
        func updateStatus(newStatus: OrderStatus) {
            self.status = newStatus
        }
        
        private static func generateUniqueID() -> String {
            return UUID().uuidString
        }
        
        static func == (lhs: Order, rhs: Order) -> Bool {
            lhs.id == rhs.id
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
}
