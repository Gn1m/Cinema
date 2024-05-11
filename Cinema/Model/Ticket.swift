//
//  Ticket.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation

enum TicketType: Hashable {
    case adult, child
}

class Ticket: Hashable {
    private var _type: TicketType
    private var _quantity: Int
    private var _price: Double
    private var _seatID: String  

    // Updated initializer to include seatID
    init(type: TicketType, quantity: Int, price: Double, seatID: String) {
        self._type = type
        self._quantity = quantity
        self._price = price
        self._seatID = seatID
    }

    var type: TicketType {
        get { _type }
        set { _type = newValue }
    }

    var quantity: Int {
        get { _quantity }
        set { _quantity = newValue }
    }

    var price: Double {
        get { _price }
        set { _price = newValue }
    }

    // Public getter for seatID
    var seatID: String {
        get { _seatID }
        set { _seatID = newValue }
    }

    static func == (lhs: Ticket, rhs: Ticket) -> Bool {
        return lhs.type == rhs.type && lhs.quantity == rhs.quantity && lhs.price == rhs.price && lhs.seatID == rhs.seatID
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(quantity)
        hasher.combine(price)
        hasher.combine(seatID)
    }
}
