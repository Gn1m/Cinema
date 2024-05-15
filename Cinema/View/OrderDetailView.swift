//
//  OrderDetailView.swift
//  Cinema
//
//  Created by Ming Z on 11/5/2024.
//

import SwiftUI

// View to display the details of a specific order
struct OrderDetailView: View {
    @EnvironmentObject var orderVM: OrderViewModel  // Use EnvironmentObject to access the shared instance of OrderViewModel
    var order: Order // The order to display details for

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Display movie name
            Text("Movie: \(order.movie.name)")
                .font(.title)
            // Display order ID
            Text("Order ID: \(order.id)")
                .font(.headline)
            // Display the ordered session date
            Text("Ordered Time: \(order.session.date.formatted())")
                .font(.headline)
            // Display the time slot of the order
            Text("Time Slot: \(order.timeSlot.startTime.formatted()) to \(order.timeSlot.endTime.formatted())")
                .font(.headline)
            
            // Uncomment to display ticket details
            // ticketDetailsView
            
            // Button to cancel the order
            Button(action: {
                orderVM.removeOrder(id: order.id) // Remove the order using the view model
            }) {
                Text("Cancel Order")
                    .foregroundColor(.red)
            }
            
            Spacer() // Push content to the top
        }
        .padding() // Add padding around the content
        .navigationTitle("Order Details") // Set the navigation title
        .navigationBarTitleDisplayMode(.inline) // Display title inline with the navigation bar
    }
    
    // Computed property to generate a view for ticket details
    // Uncomment this property to display ticket details
//    private var ticketDetailsView: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            ForEach(order.tickets, id: \.self) { ticket in
//                Text("Ticket: \(ticket.type) - Seat: \(ticket.seatID) - Price: \(ticket.price, specifier: "%.2f")")
//            }
//        }
//    }
}
