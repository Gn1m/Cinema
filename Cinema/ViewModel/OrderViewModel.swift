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

    init() {
        fetchOrders()
    }
    
    
    func fetchOrders() {
        orders = CinemaModelManager.shared.allOrders
    }


    func addOrder(_ order: Order) {
        CinemaModelManager.shared.addOrder(order)
        fetchOrders()
    }

    
    func updateOrder(id: String, newTickets: [Ticket]) {
        CinemaModelManager.shared.updateOrder(id: id, newTickets: newTickets)
        fetchOrders()
    }

    
    func cancelOrder(id: String) {
            guard let orderIndex = orders.firstIndex(where: { $0.id == id }) else {
                print("Order not found.")
                return
            }

            var order = orders[orderIndex]
            let timeSlot = order.timeSlot

            // 更新座位状态为 available
            timeSlot.seats.forEach { seat in
                if order.tickets.contains(where: { $0.seatID == seat.id }) {
                    seat.status = .available
                }
            }

            // 更新订单状态为 cancelled
            order.updateStatus(newStatus: .cancelled)
            orders[orderIndex] = order  // 保持本地缓存同步

        CinemaModelManager.shared.replaceOrders(with: orders)
            fetchOrders()  // Re-fetch orders to ensure UI is in sync
        }
}

    
