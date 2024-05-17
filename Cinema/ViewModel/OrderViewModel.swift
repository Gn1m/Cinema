//
//  OrderViewModel.swift
//  Cinema
//
//  Created by Ming Z on 6/5/2024.
//

import Foundation
import Combine

// ViewModel for managing movie orders.
class OrderViewModel: ObservableObject {
    static let shared = OrderViewModel()

    @Published private(set) var orders: [Order] = []

    // Initialises the ViewModel by fetching initial orders.
    init() {
        fetchOrders()
    }

    // Fetches orders from the model manager and updates the published orders property.
    func fetchOrders() {
        orders = CinemaModelManager.shared.currentAccountOrders
    }

    // Adds a new order and refreshes the list of orders.
    func addOrder(_ order: Order) {
        CinemaModelManager.shared.addOrder(order)
        fetchOrders()
    }

    // Updates an existing order with new tickets and refreshes the orders list.
    func updateOrder(id: String, newTickets: [Ticket]) {
        CinemaModelManager.shared.updateOrder(id: id, newTickets: newTickets)
        fetchOrders()
    }

    // Cancels an order and updates seat availability and order status accordingly.
    func cancelOrder(id: String) {
        guard let orderIndex = orders.firstIndex(where: { $0.id == id }) else {
            print("Order not found.")
            return
        }

        var order = orders[orderIndex]
        let timeSlot = order.timeSlot
        updateSeatsAsAvailable(for: order)
        order.updateStatus(newStatus: .cancelled)
        orders[orderIndex] = order  // Update local cache

        CinemaModelManager.shared.replaceOrders(with: orders)
        fetchOrders()  // Refresh local orders

        // Notify other components to update their views.
        NotificationCenter.default.post(name: .seatStatusUpdated, object: nil, userInfo: ["timeSlotID": timeSlot.id])
    }

    // Updates seat statuses to available in the Cinema Model Manager.
    private func updateSeatsAsAvailable(for order: Order) {
        for ticket in order.tickets {
            if let sessionIndex = CinemaModelManager.shared.getAllSessions.firstIndex(where: { $0.id == order.session.id }),
               let timeSlotIndex = CinemaModelManager.shared.getAllSessions[sessionIndex].timeSlots.firstIndex(where: { $0.id == order.timeSlot.id }),
               let seatIndex = CinemaModelManager.shared.getAllSessions[sessionIndex].timeSlots[timeSlotIndex].seats.firstIndex(where: { $0.id == ticket.seatID }) {
                CinemaModelManager.shared.getAllSessions[sessionIndex].timeSlots[timeSlotIndex].seats[seatIndex].status = .available
            }
        }
    }
}
