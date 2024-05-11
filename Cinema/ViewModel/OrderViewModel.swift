//
//  OrderViewModel.swift
//  Cinema
//
//  Created by Ming Z on 6/5/2024.
//

import Foundation
import Combine

class OrderViewModel: ObservableObject {
    static let shared = OrderViewModel()
    
    @Published private(set) var orders: [Order] = []
    
    // 添加新订单
    func addOrder(_ order: Order) {
        orders.append(order)
    }
    
    // 更新订单
    func updateOrder(id: String, newTickets: [Ticket]) {
        if let index = orders.firstIndex(where: { $0.id == id }) {
            // Retrieve the current order to access its timeSlot
            let currentOrder = orders[index]
            // Update the order with new tickets, keeping other details the same
            orders[index] = Order(movie: currentOrder.movie, session: currentOrder.session, timeSlot: currentOrder.timeSlot, tickets: newTickets)
        }
    }
    
    func removeOrder(id: String) {
        if let index = orders.firstIndex(where: { $0.id == id }) {
            let order = orders[index]
            orders.remove(at: index)
        }
    }
}
    
