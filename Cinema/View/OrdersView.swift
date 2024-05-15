//
//  OrdersView.swift
//  Cinema
//
//  Created by Ming Z on 6/5/2024.
//

import SwiftUI

// View to display a list of orders
struct OrdersView: View {
    @ObservedObject var viewModel = OrderViewModel.shared // ObservedObject to manage the order data

    var body: some View {
        NavigationView {
            List {
                // Loop through each order and create a navigation link to the order detail view
                ForEach(viewModel.orders, id: \.id) { order in
                    NavigationLink(destination: OrderDetailView(order: order)) {
                        VStack(alignment: .leading) {
                            Text(order.movie.name)
                                .font(.headline)
                            Text("Session: \(order.session.date.formatted())")
                                .font(.subheadline)
                            Text("Order ID: \(order.id)")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteOrder) // Enable deletion of orders
            }
            .navigationTitle("Orders") // Set the navigation title
        }
    }

    // Function to delete an order from the list
    func deleteOrder(at offsets: IndexSet) {
        offsets.forEach { index in
            let orderId = viewModel.orders[index].id
            viewModel.removeOrder(id: orderId) // Call the view model to remove the order
        }
    }
}
