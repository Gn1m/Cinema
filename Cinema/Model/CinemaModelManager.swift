//
//  CinemaModelManager.swift
//  Cinema
//
//  Created by Ming Z on 11/5/2024.
//
import Foundation
import Combine

class CinemaModelManager {
    static let shared = CinemaModelManager()

    private var allMovies: [Movie] = []
    private var releasedMovies: [ReleasedMovie] = []
    private var comingSoonMovies: [ComingSoonMovie] = []
    private var allSessions: [Session] = []
    private var orders: [Order] = []
    
    private var hasLoadedMovies = false

    private init() {
        loadMovies()
    }

    private func loadMovies() {
        if !hasLoadedMovies {
            releasedMovies = SampleMoviesProvider.getReleasedMovies()
            comingSoonMovies = SampleMoviesProvider.getComingSoonMovies()
            allMovies = releasedMovies + comingSoonMovies as [Movie]

            // Flatten all sessions from released movies for easy access by ID
            allSessions = releasedMovies.flatMap { $0.sessions }
            hasLoadedMovies = true
        }
    }

    func movie(forID id: String) -> Movie? {
        return allMovies.first { $0.id == id }
    }

    func session(forID id: String) -> Session? {
        return allSessions.first { $0.id == id }
    }

    func updateMovies(movies: [ReleasedMovie]) {
        self.releasedMovies = movies
        self.allMovies = releasedMovies + comingSoonMovies as [Movie]
        self.allSessions = releasedMovies.flatMap { $0.sessions }
    }
    
    // Public getter for released movies
        public var getReleasedMovies: [ReleasedMovie] {
            return releasedMovies
        }

        // Public getter for coming soon movies
        public var getComingSoonMovies: [ComingSoonMovie] {
            return comingSoonMovies
        }
    
    var allOrders: [Order] {
            return orders
        }
    
    func addOrder(_ order: Order) {
            orders.append(order)
        }
        
        
        func updateOrder(id: String, newTickets: [Ticket]) {
            if let index = orders.firstIndex(where: { $0.id == id }) {
                let currentOrder = orders[index]
                orders[index] = Order(movie: currentOrder.movie, session: currentOrder.session, timeSlot: currentOrder.timeSlot, tickets: newTickets)
            }
        }
        
        
        func removeOrder(id: String) {
            orders.removeAll { $0.id == id }
        }

        
    func replaceOrders(with newOrders: [Order]) {
            orders = newOrders
        }
    
}
