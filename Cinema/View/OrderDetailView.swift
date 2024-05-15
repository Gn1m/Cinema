//
//  OrderDetailView.swift
//  Cinema
//
//  Created by Ming Z on 11/5/2024.
//

import SwiftUI

struct OrderDetailView: View {
    @EnvironmentObject var orderVM: OrderViewModel
    let orderID: String

    var order: Order? {
        orderVM.orders.first { $0.id == orderID }
    }

    var body: some View {
        ScrollView {
            if let order = order {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Movie: \(order.movie.name)")
                        .font(.title)
                    Text("Order ID: \(order.id)")
                        .font(.headline)
                    Text("Ordered Time: \(order.session.date.formatted())")
                        .font(.headline)
                    Text("Time Slot: \(order.timeSlot.startTime.formatted()) to \(order.timeSlot.endTime.formatted())")
                        .font(.headline)
                    Text("Order Status: \(order.status.rawValue)")
                        .font(.headline)
                    ticketDetailsView(order: order)
                    if order.status != .cancelled {
                        Button("Cancel Order") {
                            orderVM.cancelOrder(id: order.id)
                        }
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    Spacer()
                }
                .padding()
                .navigationTitle("Order Details")
                .navigationBarTitleDisplayMode(.inline)
            } else {
                Text("Order not found.")
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }

    private func ticketDetailsView(order: Order) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(order.tickets, id: \.id) { ticket in
                Text("Ticket: \(ticket.type.rawValue) x \(ticket.quantity) - Seat ID: \(ticket.seatID)")
            }
        }
    }
}
