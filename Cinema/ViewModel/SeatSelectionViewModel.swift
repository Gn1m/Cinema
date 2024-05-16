//
//  SeatSelectionViewModel.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation
import Combine

/// ViewModel for managing seat selection
class SeatSelectionViewModel: ObservableObject {
    @Published var currentTimeSlot: TimeSlot
    @Published var seats: [Seat]
    @Published var selectedSeats: Set<String> = []
    @Published var adultTickets: Int = 0
    @Published var childTickets: Int = 0
    @Published var errorMessage: String?

    private let adultTicketPrice: Double = TicketType.adult.defaultPrice
    private let childTicketPrice: Double = TicketType.child.defaultPrice

    /// Initializer to set up the time slot and seats
    init(timeSlotID: String) {
        guard let timeSlot = CinemaModelManager.shared.getAllSessions
                .flatMap({ $0.timeSlots })
                .first(where: { $0.id == timeSlotID }) else {
            fatalError("Invalid timeSlotID")
        }
        self.currentTimeSlot = timeSlot
        self.seats = timeSlot.seats

        NotificationCenter.default.addObserver(self, selector: #selector(handleSeatStatusUpdate(_:)), name: .seatStatusUpdated, object: nil)
        loadReservations()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    /// Computed property to get the total ticket count
    var totalTicketCount: Int {
        return adultTickets + childTickets
    }

    /// Computed property to get the total price of tickets
    var totalPrice: Double {
        return (Double(adultTickets) * adultTicketPrice) + (Double(childTickets) * childTicketPrice)
    }

    /// Method to toggle seat selection
    func toggleSeatSelection(_ seatID: String) {
        if selectedSeats.contains(seatID) {
            selectedSeats.remove(seatID)
        } else if selectedSeats.count < totalTicketCount {
            selectedSeats.insert(seatID)
        } else {
            errorMessage = "You've exceeded the number of available seats. Please adjust your ticket count."
        }
        errorMessage = nil
    }

    /// Method to reserve selected seats
    func reserveSelectedSeats() {
        guard selectedSeats.count == totalTicketCount else {
            errorMessage = "Please select exactly \(totalTicketCount) seats."
            return
        }

        for seatID in selectedSeats {
            if let index = seats.firstIndex(where: { $0.id == seatID }) {
                seats[index] = seats[index].withStatus(.reserved)
            }
        }

        saveReservations()
        addOrder()
        errorMessage = nil
    }

    /// Method to save reservations to UserDefaults
    private func saveReservations() {
        let reservedSeats = seats.filter { $0.status == .reserved }.map { $0.id }
        UserDefaults.standard.set(reservedSeats, forKey: "reservedSeats_\(currentTimeSlot.id)")
    }

    /// Method to check if seat selection is valid
    func isSeatSelectionValid() -> Bool {
        return selectedSeats.count == totalTicketCount
    }

    /// Method to add an order
    private func addOrder() {
        guard selectedSeats.count == totalTicketCount else {
            errorMessage = "Please select exactly \(totalTicketCount) seats."
            return
        }

        guard let movie = CinemaModelManager.shared.movie(forID: currentTimeSlot.movieId),
              let session = CinemaModelManager.shared.session(forID: currentTimeSlot.sessionId) else {
            errorMessage = "Error fetching movie or session details."
            return
        }

        if selectedSeats.count != adultTickets + childTickets {
            errorMessage = "Number of selected seats does not match the number of tickets."
            return
        }

        var tickets: [Ticket] = []
        let selectedSeatIDs = Array(selectedSeats)
        for i in 0..<adultTickets {
            tickets.append(Ticket.defaultAdultTicket(seatID: selectedSeatIDs[i]))
        }
        for i in 0..<childTickets {
            tickets.append(Ticket.defaultChildTicket(seatID: selectedSeatIDs[adultTickets + i]))
        }

        let newOrder = Order(movie: movie, session: session, timeSlot: currentTimeSlot, tickets: tickets, account: CinemaModelManager.shared.currentAccount)
        CinemaModelManager.shared.addOrder(newOrder)
    }

    /// Method to load reservations from UserDefaults
    func loadReservations() {
        if let reservedSeats = UserDefaults.standard.array(forKey: "reservedSeats_\(currentTimeSlot.id)") as? [String] {
            for seatID in reservedSeats {
                if let index = seats.firstIndex(where: { $0.id == seatID }) {
                    seats[index].status = .reserved
                }
            }
        }
    }

    /// Method to cancel a reserved seat
    func cancelSeat(seatID: String) {
        if let index = seats.firstIndex(where: { $0.id == seatID }) {
            seats[index].status = .available
        }
    }

    /// Method to handle seat status updates
    @objc private func handleSeatStatusUpdate(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let timeSlotID = userInfo["timeSlotID"] as? String, timeSlotID == currentTimeSlot.id else {
            return
        }
        self.seats = currentTimeSlot.seats
    }

    /// Method to reload the session and seats from CinemaModelManager
    func reloadSession(timeSlotID: String) {
        guard let timeSlot = CinemaModelManager.shared.getAllSessions
                .flatMap({ $0.timeSlots })
                .first(where: { $0.id == timeSlotID }) else {
            errorMessage = "Invalid timeSlotID"
            return
        }
        self.currentTimeSlot = timeSlot
        self.seats = timeSlot.seats
        loadReservations()
    }
}


// Extension for Notification.Name to define a new notification for seat status updates
extension Notification.Name {
    static let seatStatusUpdated = Notification.Name("seatStatusUpdated")
}
