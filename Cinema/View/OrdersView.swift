//
//  OrdersView.swift
//  Cinema
//
//  Created by Ming Z on 6/5/2024.
//

import SwiftUI

/// View displaying a list of orders made by the user.
struct OrdersView: View {
    @ObservedObject var viewModel = OrderViewModel.shared // Access the shared instance of the OrderViewModel.

    var body: some View {
        NavigationStack {
            List {
                // Conditionally display either a message or a list of orders.
                if viewModel.orders.isEmpty {
                    // Display a message when there are no orders.
                    Text("No orders available")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    // Iterate through each order and create a navigation link to its detail view.
                    ForEach(viewModel.orders, id: \.id) { order in
                        NavigationLink(destination: OrderDetailView(orderID: order.id).environmentObject(viewModel)) {
                            VStack(alignment: .leading) {
                                // Display the movie name as a headline.
                                Text(order.movie.name)
                                    .font(.headline)
                                // Display the session date in a subheadline font.
                                Text("Session: \(order.session.date.formatted())")
                                    .font(.subheadline)
                                // Display the order ID in a subheadline font.
                                Text("Order ID: \(order.id)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Orders") // Set the title for the navigation bar.
            .onAppear {
                viewModel.fetchOrders() // Fetch the list of orders when the view appears.
            }
        }
    }
}

/// Preview provider for SwiftUI previews in Xcode.
struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
