//
//  ContentView.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import SwiftUI

/// The main view component for the application, responsible for displaying the movie categories and navigation options.
struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel() // ViewModel to manage the state of movie categories and selected movies.
    @StateObject private var accountController = AccountController.shared // Access the shared AccountController instance for user account management.
    @State private var navigateToOrders = false // State to control navigation to the Orders view.
    @State private var navigateToAccount = false // State to control navigation to the Account view.

    var body: some View {
        NavigationStack {
            VStack {
                // Segmented Picker to switch between 'Now Showing' and 'Coming Soon' categories.
                Picker("Category", selection: $viewModel.selectedCategory) {
                    Text("Now Showing").tag(ContentViewModel.MovieCategory.nowShowing)
                    Text("Coming Soon").tag(ContentViewModel.MovieCategory.comingSoon)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .onChange(of: viewModel.selectedCategory) { newCategory in
                    viewModel.updateMoviesForSelectedCategory() // Update movies list when category changes.
                }

                // Horizontal scroll view to display movies from the selected category.
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.selectedMovies, id: \.id) { movie in
                            NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                                MovieCardView(movie: movie) // Display each movie in a card format.
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
                                navigateToOrders = true // Navigate to Orders view when tapped.
                            }) {
                                Label("Orders", systemImage: "cart")
                            }

                            Button(action: {
                                navigateToAccount = true // Navigate to Account view when tapped.
                            }) {
                                Label("Account", systemImage: "person.crop.circle")
                            }
                        } label: {
                            Image(systemName: "info.circle") // Display an info icon in the navigation bar.
                        }
                    }
                }

                NavigationLink(destination: OrdersView(), isActive: $navigateToOrders) { EmptyView() }
                NavigationLink(destination: AccountView().environmentObject(accountController), isActive: $navigateToAccount) { EmptyView() }
            }
        }
        .environmentObject(accountController) // Provide the AccountController to all subviews.
    }
}

/// Preview provider for ContentView, useful in Xcode previews.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
