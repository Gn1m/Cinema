//
//  Ticket.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation

enum TicketType: String, Hashable {
    case adult, child
}

class Ticket: Identifiable, Hashable {
    let id = UUID()
    let type: TicketType
    let quantity: Int
    let price: Double
    let seatID: String

    init(type: TicketType, quantity: Int, price: Double, seatID: String) {
        self.type = type
        self.quantity = quantity
        self.price = price
        self.seatID = seatID
    }

    static func == (lhs: Ticket, rhs: Ticket) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
