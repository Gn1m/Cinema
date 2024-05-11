//
//  OrderDetailView.swift
//  Cinema
//
//  Created by Ming Z on 11/5/2024.
//

import SwiftUI

struct OrderDetailView: View {
    @EnvironmentObject var orderVM: OrderViewModel  // Use EnvironmentObject to access the shared instance
    var order: Order

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Movie: \(order.movie.name)")
                .font(.title)
            Text("Order ID: \(order.id)")
                .font(.headline)
            Text("Ordered Time: \(order.session.date.formatted())")
                .font(.headline)
            Text("Time Slot: \(order.timeSlot.startTime.formatted()) to \(order.timeSlot.endTime.formatted())")
                .font(.headline)
            //ticketDetailsView
            Button(action: {
                orderVM.removeOrder(id: order.id)
            }) {
                Text("Cancel Order")
                    .foregroundColor(.red)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Order Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
//     Computed property to generate a view for ticket details
//    private var ticketDetailsView: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            ForEach(order.tickets, id: \.self) { ticket in
//                Text("Ticket: \(ticket.type) - Seat: \(ticket.seatID) - Price: \(ticket.price, specifier: "%.2f")")
//            }
//        }
//    }
}
