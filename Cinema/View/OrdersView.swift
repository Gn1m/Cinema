//
//  OrdersView.swift
//  Cinema
//
//  Created by Ming Z on 6/5/2024.
//

import SwiftUI

struct OrdersView: View {
    @ObservedObject var viewModel = OrderViewModel.shared

    var body: some View {
        NavigationView {
            List {
                if viewModel.orders.isEmpty {
                    Text("No orders available")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(viewModel.orders, id: \.id) { order in
                        NavigationLink(destination: OrderDetailView(orderID: order.id)) {
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
                }
            }
            .navigationTitle("Orders")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Refresh") {
                        viewModel.fetchOrders()
                    }
                }
            }
        }
    }
}
