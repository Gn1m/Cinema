//
//  Ticket.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation

enum TicketType: Hashable  {
    case adult, child
}

class Ticket: Hashable  {
    private var _type: TicketType
    private var _quantity: Int
    private var _price: Double
    
    init(type: TicketType, quantity: Int, price: Double) {
        self._type = type
        self._quantity = quantity
        self._price = price
    }

    var type: TicketType {
        get {
            return _type
        }
        set(newType) {
            _type = newType
        }
    }

    var quantity: Int {
        get {
            return _quantity
        }
        set(newQuantity) {
            _quantity = newQuantity
        }
    }
    
    var price: Double {
        get {
            return _price
        }
        set(newPrice) {
            _price = newPrice
        }
    }
    
    static func == (lhs: Ticket, rhs: Ticket) -> Bool {
           lhs.type == rhs.type && lhs.quantity == rhs.quantity && lhs.price == rhs.price
       }

       func hash(into hasher: inout Hasher) {
           hasher.combine(type)
           hasher.combine(quantity)
           hasher.combine(price)
       }
}
