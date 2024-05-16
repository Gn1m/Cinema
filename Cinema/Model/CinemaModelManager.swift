//
//  CinemaModelManager.swift
//  Cinema
//
//  Created by Ming Z on 11/5/2024.
//

import Foundation
import Combine

/// Manages the data related to cinema operations including movies, sessions, and orders.
class CinemaModelManager: ObservableObject {
    static let shared = CinemaModelManager()  // Singleton instance of the CinemaModelManager.

    private var allMovies: [Movie] = []  // All movies, both released and upcoming.
    private var releasedMovies: [ReleasedMovie] = []  // Movies that have already been released.
    private var comingSoonMovies: [ComingSoonMovie] = []  // Movies that are scheduled for future release.
    private var allSessions: [Session] = []  // All movie sessions available.
    @Published private(set) var currentAccount: AccountModel?  // The currently logged-in account.
    private var orders: [Order] = []  // All orders made.

    private var hasLoadedMovies = false  // Flag to check if movies have been loaded.

    /// Initializes and loads initial data.
    private init() {
        loadMovies()
    }

    /// Loads movies from a sample provider.
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

    /// Retrieves a movie by its ID.
    func movie(forID id: String) -> Movie? {
        return allMovies.first { $0.id == id }
    }

    /// Retrieves a session by its ID.
    func session(forID id: String) -> Session? {
        return allSessions.first { $0.id == id }
    }

    /// Updates the list of movies.
    func updateMovies(movies: [ReleasedMovie]) {
        self.releasedMovies = movies
        self.allMovies = releasedMovies + comingSoonMovies
        self.allSessions = releasedMovies.flatMap { $0.sessions }
    }

    /// Returns released movies.
    public var getReleasedMovies: [ReleasedMovie] {
        return releasedMovies
    }

    /// Returns movies that are coming soon.
    public var getComingSoonMovies: [ComingSoonMovie] {
        return comingSoonMovies
    }

    /// Returns all sessions.
    public var getAllSessions: [Session] {
        return allSessions
    }

    /// Returns all orders.
    var allOrders: [Order] {
        return orders
    }

    /// Adds a new order.
    func addOrder(_ order: Order) {
        orders.append(order)
    }

    /// Updates an existing order with new tickets.
    func updateOrder(id: String, newTickets: [Ticket]) {
        if let index = orders.firstIndex(where: { $0.id == id }) {
            let currentOrder = orders[index]
            orders[index] = Order(movie: currentOrder.movie, session: currentOrder.session, timeSlot: currentOrder.timeSlot, tickets: newTickets, account: currentOrder.account)
        }
    }

    /// Removes an order by its ID.
    func removeOrder(id: String) {
        orders.removeAll { $0.id == id }
    }

    /// Replaces the current list of orders with a new one.
    func replaceOrders(with newOrders: [Order]) {
        orders = newOrders
    }

    /// Adds a new session.
    func addSession(_ session: Session) {
        allSessions.append(session)
    }

    /// Updates an existing session with new time slots.
    func updateSession(id: String, newTimeSlots: [TimeSlot]) {
        if let index = allSessions.firstIndex(where: { $0.id == id }) {
            allSessions[index].timeSlots = newTimeSlots
        }
    }

    /// Removes a session by its ID.
    func removeSession(id: String) {
        allSessions.removeAll { $0.id == id }
    }

    /// Replaces the current list of sessions with a new one.
    func replaceSessions(with newSessions: [Session]) {
        allSessions = newSessions
    }

    /// Logs in with a specified account.
    func login(account: AccountModel) {
        self.currentAccount = account
    }

    /// Logs out the current user and removes their orders.
    func logout() {
        self.currentAccount = nil
        orders.removeAll { $0.account != nil }  // Remove all orders associated with an account
    }

    /// Retrieves orders made by the currently logged-in account.
    var currentAccountOrders: [Order] {
        if let account = currentAccount {
            return orders.filter { $0.account?.account == account.account }
        } else {
            return orders.filter { $0.account == nil }  // Orders placed as guest
        }
    }
}
