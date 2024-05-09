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
        NavigationStack {
            VStack {
                // Switch between Now Showing and Coming Soon
                Picker("Category", selection: $viewModel.selectedCategory) {
                    Text("Now Showing").tag(ContentViewModel.MovieCategory.nowShowing)
                    Text("Coming Soon").tag(ContentViewModel.MovieCategory.comingSoon)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .onChange(of: viewModel.selectedCategory) { newCategory in
                    viewModel.updateSelectedMovies(category: newCategory)
                }

                // Movie cards
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.selectedMovies, id: \.id) { movie in
                            NavigationLink(value: movie) {
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

                // Navigation to Orders and Account
                NavigationLink(value: "orders", label: { EmptyView() })
                    .hidden()
                    .frame(width: 0, height: 0)

                NavigationLink(value: "account", label: { EmptyView() })
                    .hidden()
                    .frame(width: 0, height: 0)
            }
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(movie: movie)
            }
            .navigationDestination(for: String.self) { destination in
                switch destination {
                case "orders":
                    OrdersView()
                case "account":
                    AccountView()
                default:
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
