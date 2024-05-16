//
//  OrderDetailView.swift
//  Cinema
//
//  Created by Ming Z on 11/5/2024.
//

import SwiftUI
import UIKit

/// A view to detail the selected order, providing comprehensive information and actions like cancellation.
struct OrderDetailView: View {
    @EnvironmentObject var orderVM: OrderViewModel // Use the shared Order ViewModel.
    let orderID: String // ID for the order to be detailed.
    private let barcodeGenerator = BarcodeGenerator() // Instance of BarcodeGenerator

    /// Retrieves the order based on the ID from the ViewModel.
    var order: Order? {
        orderVM.orders.first { $0.id == orderID }
    }

    var body: some View {
        ScrollView {
            if let order = order {
                VStack(alignment: .leading, spacing: 20) {
                    // Movie title
                    Text("Movie: \(order.movie.name)")
                        .font(.title)
                    
                    // Unique identifier for the order
                    Text("Order ID: \(order.id)")
                        .font(.headline)
                    
                    // Session date and time details
                    Text("Ordered Time: \(order.session.date.formatted())")
                        .font(.headline)
                    
                    // Time slot details showing start and end times
                    Text("Time Slot: \(order.timeSlot.startTime.formatted()) to \(order.timeSlot.endTime.formatted())")
                        .font(.headline)
                    
                    // Status of the order, e.g., confirmed or cancelled
                    Text("Order Status: \(order.status.rawValue)")
                        .font(.headline)

                    // Show who purchased the order
                    if let account = order.account {
                        Text("Purchased by: \(account.username) (\(account.email))")
                            .font(.subheadline)
                    } else {
                        Text("Purchased by: Guest")
                            .font(.subheadline)
                    }

                    // Show tickets with details in a structured view
                    ticketDetailsView(order: order)

                    // Generate and display a barcode for the order ID
                    if let barcodeImage = barcodeGenerator.generateBarcode(from: order.id) {
                        Image(uiImage: barcodeImage)
                            .resizable()
                            .interpolation(.none)
                            .scaledToFit()
                            .frame(height: 150)
                            .padding(.top, 20)
                    }

                    // Button to cancel the order if applicable
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

    /// Subview to display ticket details for each ticket in the order.
    private func ticketDetailsView(order: Order) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(order.tickets, id: \.id) { ticket in
                Text("Ticket: \(ticket.type.rawValue) x \(ticket.quantity) - Seat ID: \(ticket.seatID) - Price: \(ticket.price, specifier: "%.2f")")
            }
        }
    }
}

/// Preview provider to help visualize the layout in Xcode's canvas.
struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMovie = Movie(id: "1", name: "Sample Movie", description: "Sample Description", trailerLink: nil, imageURL: nil)
        let sampleSession = Session(id: "1", date: Date(), timeSlots: [], movieId: "1")
        let sampleTimeSlot = TimeSlot(id: "1", startTime: Date(), endTime: Date(), seats: [], sessionId: "1", movieId: "1")
        let sampleOrder = Order(movie: sampleMovie, session: sampleSession, timeSlot: sampleTimeSlot, tickets: [], account: AccountModel(username: "Test User", account: "test", email: "test@example.com", password: "Password1"))

        OrderDetailView(orderID: sampleOrder.id)
            .environmentObject(OrderViewModel.shared)
    }
}
