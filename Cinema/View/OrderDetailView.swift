//
//  OrderDetailView.swift
//  Cinema
//
//  Created by Ming Z on 11/5/2024.
//

import SwiftUI
import UIKit

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

                    if let account = order.account {
                        Text("Purchased by: \(account.username) (\(account.email))")
                            .font(.subheadline)
                    } else {
                        Text("Purchased by: Guest")
                            .font(.subheadline)
                    }

                    ticketDetailsView(order: order)

                    if let barcodeImage = generateBarcode(from: order.id) {
                        Image(uiImage: barcodeImage)
                            .resizable()
                            .interpolation(.none)
                            .scaledToFit()
                            .frame(height: 150)
                            .padding(.top, 20)
                    }

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
                Text("Ticket: \(ticket.type.rawValue) x \(ticket.quantity) - Seat ID: \(ticket.seatID) - Price: \(ticket.price, specifier: "%.2f")")
            }
        }
    }

    private func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            if let output = filter.outputImage {
                let scaleX = 3.0
                let scaleY = 3.0
                let transformedImage = output.transformed(by: CGAffineTransform(scaleX: CGFloat(scaleX), y: CGFloat(scaleY)))
                return UIImage(ciImage: transformedImage)
            }
        }
        return nil
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample order for preview
        let sampleMovie = Movie(id: "1", name: "Sample Movie", description: "Sample Description", trailerLink: nil, imageURL: nil)
        let sampleSession = Session(id: "1", date: Date(), timeSlots: [], movieId: "1")
        let sampleTimeSlot = TimeSlot(id: "1", startTime: Date(), endTime: Date(), seats: [], sessionId: "1", movieId: "1")
        let sampleOrder = Order(movie: sampleMovie, session: sampleSession, timeSlot: sampleTimeSlot, tickets: [], account: AccountModel(username: "Test User", account: "test", email: "test@example.com", password: "Password1"))

        OrderDetailView(orderID: sampleOrder.id)
            .environmentObject(OrderViewModel.shared)
    }
}
