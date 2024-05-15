//
//  MovieDetailView.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import SwiftUI

// Main ContentView
struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel() // ViewModel instance to manage the state and business logic
    @State private var navigateToOrders = false // State to control navigation to Orders view
    @State private var navigateToAccount = false // State to control navigation to Account view
    
    var body: some View {
        NavigationView {
            NavigationStack {
                VStack {
                    // Picker that to switch between Now Showing and Coming Soon categories
                    Picker("Category", selection: $viewModel.selectedCategory) {
                        Text("Now Showing").tag(ContentViewModel.MovieCategory.nowShowing)
                        Text("Coming Soon").tag(ContentViewModel.MovieCategory.comingSoon)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .onChange(of: viewModel.selectedCategory) { newCategory in
                        // Update the movies displayed based on the selected category
                        viewModel.updateSelectedMovies(category: newCategory)
                    }
                    
                    // Horizontal ScrollView to display movie cards
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.selectedMovies, id: \.id) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    MovieCardView(movie: movie) // Custom view to display a movie card
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .navigationTitle("Movies")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            // Menu button with options to navigate to Orders and Account views
                            Menu {
                                Button(action: {
                                    navigateToOrders = true // Set to true to trigger navigation to Orders view
                                }) {
                                    Label("Orders", systemImage: "cart")
                                }
                                
                                Button(action: {
                                    navigateToAccount = true // Set to true to trigger navigation to Account view
                                }) {
                                    Label("Account", systemImage: "person.crop.circle")
                                }
                            } label: {
                                Image(systemName: "info.circle")
                            }
                        }
                    }
                    
                    // Invisible NavigationLinks to trigger programmatic navigation
                    NavigationLink(destination: OrdersView(), isActive: $navigateToOrders) { EmptyView() }
                        .frame(width: 0, height: 0)
                    
                    NavigationLink(destination: AccountView(), isActive: $navigateToAccount) { EmptyView() }
                        .frame(width: 0, height: 0)
                }
            }
        }
    }
    
    // Preview provider for the ContentView
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
