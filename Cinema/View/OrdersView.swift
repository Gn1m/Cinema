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
                .onDelete(perform: deleteOrder)
            }
            .navigationTitle("Orders")
        }
    }

    func deleteOrder(at offsets: IndexSet) {
        offsets.forEach { index in
            let orderId = viewModel.orders[index].id
            viewModel.removeOrder(id: orderId)
        }
    }
}
