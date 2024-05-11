//
//  OrderDetailView.swift
//  Cinema
//
//  Created by Ming Z on 11/5/2024.
//

import SwiftUI

struct OrderDetailView: View {
    var order: Order

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Movie: \(order.movie.name)")
                .font(.title)
            Text("ordered time: \(order.session.date.formatted())")
                .font(.headline)
            Text("Time Slot: \(order.timeSlot.startTime.formatted()) to \(order.timeSlot.endTime.formatted())")
                .font(.headline)
            Text("Tickets: \(order.ticketDetails)")
                .font(.headline)
            Spacer()
        }
        .padding()
        .navigationTitle("Order Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
