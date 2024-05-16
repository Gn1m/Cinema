//
//  CinemaModelManager.swift
//  Cinema
//
//  Created by Ming Z on 11/5/2024.
//

import Foundation
import Combine

/// Model manager for managing cinema data
class CinemaModelManager: ObservableObject {
    static let shared = CinemaModelManager()

    private var allMovies: [Movie] = []
    private var releasedMovies: [ReleasedMovie] = []
    private var comingSoonMovies: [ComingSoonMovie] = []
    private var allSessions: [Session] = []
    @Published private(set) var currentAccount: AccountModel?
    private var orders: [Order] = []

    private var hasLoadedMovies = false

    /// Initializer to load initial data
    private init() {
        loadMovies()
    }

    /// Method to load movies from the sample provider
    private func loadMovies() {
        if !hasLoadedMovies {
            releasedMovies = SampleMoviesProvider.getReleasedMovies()
            comingSoonMovies = SampleMoviesProvider.getComingSoonMovies()
            allMovies = releasedMovies + comingSoonMovies

            // Flatten all sessions from released movies for easy access by ID
            allSessions = releasedMovies.flatMap { $0.sessions }
            hasLoadedMovies = true
        }
    }

    /// Method to get a movie by its ID
    func movie(forID id: String) -> Movie? {
        return allMovies.first { $0.id == id }
    }

    /// Method to get a session by its ID
    func session(forID id: String) -> Session? {
        return allSessions.first { $0.id == id }
    }

    /// Method to update the list of movies
    func updateMovies(movies: [ReleasedMovie]) {
        self.releasedMovies = movies
        self.allMovies = releasedMovies + comingSoonMovies
        self.allSessions = releasedMovies.flatMap { $0.sessions }
    }

    /// Computed property to get released movies
    public var getReleasedMovies: [ReleasedMovie] {
        return releasedMovies
    }

    /// Computed property to get coming soon movies
    public var getComingSoonMovies: [ComingSoonMovie] {
        return comingSoonMovies
    }

    /// Computed property to get all sessions
    public var getAllSessions: [Session] {
        return allSessions
    }

    /// Computed property to get all orders
    var allOrders: [Order] {
        return orders
    }

    /// Method to add a new order
    func addOrder(_ order: Order) {
        orders.append(order)
    }

    /// Method to update an existing order
    func updateOrder(id: String, newTickets: [Ticket]) {
        if let index = orders.firstIndex(where: { $0.id == id }) {
            let currentOrder = orders[index]
            orders[index] = Order(movie: currentOrder.movie, session: currentOrder.session, timeSlot: currentOrder.timeSlot, tickets: newTickets, account: currentOrder.account)
        }
    }

    /// Method to remove an order by its ID
    func removeOrder(id: String) {
        orders.removeAll { $0.id == id }
    }

    /// Method to replace the list of orders
    func replaceOrders(with newOrders: [Order]) {
        orders = newOrders
    }

    /// Method to add a new session
    func addSession(_ session: Session) {
        allSessions.append(session)
    }

    /// Method to update an existing session
    func updateSession(id: String, newTimeSlots: [TimeSlot]) {
        if let index = allSessions.firstIndex(where: { $0.id == id }) {
            allSessions[index].timeSlots = newTimeSlots
        }
    }

    /// Method to remove a session by its ID
    func removeSession(id: String) {
        allSessions.removeAll { $0.id == id }
    }

    /// Method to replace the list of sessions
    func replaceSessions(with newSessions: [Session]) {
        allSessions = newSessions
    }

    /// Method to log in with an account
    func login(account: AccountModel) {
        self.currentAccount = account
    }

    /// Method to log out
    func logout() {
        self.currentAccount = nil
        orders.removeAll { $0.account != nil } // Remove all orders associated with an account
    }

    /// Computed property to get orders of the current account
    var currentAccountOrders: [Order] {
        if let account = currentAccount {
            return orders.filter { $0.account?.account == account.account }
        } else {
            return orders.filter { $0.account == nil }  // Orders placed as guest
        }
    }
}
