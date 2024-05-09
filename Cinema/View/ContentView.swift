//
//  MovieDetailView.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var navigateToOrders = false
    @State private var navigateToAccount = false

    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.movies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieCardView(movie: movie)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .navigationTitle("Movies")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button(action: {
                                navigateToOrders = true
                            }) {
                                Label("Orders", systemImage: "cart")
                            }

                            Button(action: {
                                navigateToAccount = true
                            }) {
                                Label("Account", systemImage: "person.crop.circle")
                            }
                        } label: {
                            Image(systemName: "info.circle")
                        }
                    }
                }

                NavigationLink(destination: OrdersView(), isActive: $navigateToOrders) {
                    EmptyView()
                }

                NavigationLink(destination: AccountView(), isActive: $navigateToAccount) {
                    EmptyView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
