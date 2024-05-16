//
//  OrderViewModel.swift
//  Cinema
//
//  Created by Ming Z on 6/5/2024.
//

import Foundation
import Combine

/// ViewModel for managing orders
class OrderViewModel: ObservableObject {
    static let shared = OrderViewModel()

    /// Published property to hold the list of orders
    @Published private(set) var orders: [Order] = []

    /// Initializer to fetch initial orders
    init() {
        fetchOrders()
    }

    /// Method to fetch orders from the model manager
    func fetchOrders() {
        orders = CinemaModelManager.shared.currentAccountOrders
    }

    /// Method to add a new order
    func addOrder(_ order: Order) {
        CinemaModelManager.shared.addOrder(order)
        fetchOrders()
    }

    /// Method to update an existing order
    func updateOrder(id: String, newTickets: [Ticket]) {
        CinemaModelManager.shared.updateOrder(id: id, newTickets: newTickets)
        fetchOrders()
    }

    /// Method to cancel an existing order
    func cancelOrder(id: String) {
        guard let orderIndex = orders.firstIndex(where: { $0.id == id }) else {
            print("Order not found.")
            return
        }

        var order = orders[orderIndex]
        let timeSlot = order.timeSlot

        // Update seat status to available
        for ticket in order.tickets {
            if let sessionIndex = CinemaModelManager.shared.getAllSessions.firstIndex(where: { $0.id == order.session.id }) {
                if let timeSlotIndex = CinemaModelManager.shared.getAllSessions[sessionIndex].timeSlots.firstIndex(where: { $0.id == timeSlot.id }) {
                    if let seatIndex = CinemaModelManager.shared.getAllSessions[sessionIndex].timeSlots[timeSlotIndex].seats.firstIndex(where: { $0.id == ticket.seatID }) {
                        CinemaModelManager.shared.getAllSessions[sessionIndex].timeSlots[timeSlotIndex].seats[seatIndex].status = .available
                    }
                }
            }
        }

        // Update order status to cancelled
        order.updateStatus(newStatus: .cancelled)
        orders[orderIndex] = order  // Keep the local cache in sync

        CinemaModelManager.shared.replaceOrders(with: orders)
        fetchOrders()  // Re-fetch orders to ensure UI is in sync

        // Notify SeatSelectionViewModel to update seat statuses
        NotificationCenter.default.post(name: .seatStatusUpdated, object: nil, userInfo: ["timeSlotID": timeSlot.id])
    }
}
