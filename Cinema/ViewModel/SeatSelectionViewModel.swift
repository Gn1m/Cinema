//
//  SeatSelectionViewModel.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation
import Combine

class SeatSelectionViewModel: ObservableObject {
    @Published var currentTimeSlot: TimeSlot
    @Published var seats: [Seat]
    @Published var selectedSeats: Set<String> = []
    @Published var adultTickets: Int = 0
    @Published var childTickets: Int = 0
    @Published var errorMessage: String?

    private let adultTicketPrice: Double = 12.0
    private let childTicketPrice: Double = 8.0

    init(timeSlotID: String) {
        guard let timeSlot = CinemaModelManager.shared.getAllSessions
                .flatMap({ $0.timeSlots })
                .first(where: { $0.id == timeSlotID }) else {
            fatalError("Invalid timeSlotID")
        }
        self.currentTimeSlot = timeSlot
        self.seats = timeSlot.seats
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleSeatStatusUpdate(_:)), name: .seatStatusUpdated, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    var totalTicketCount: Int {
        return adultTickets + childTickets
    }

    var totalPrice: Double {
        return (Double(adultTickets) * adultTicketPrice) + (Double(childTickets) * childTicketPrice)
    }

    func toggleSeatSelection(_ seatID: String) {
        if selectedSeats.contains(seatID) {
            selectedSeats.remove(seatID)
            errorMessage = nil
        } else if selectedSeats.count < totalTicketCount {
            selectedSeats.insert(seatID)
            errorMessage = nil
        } else {
            errorMessage = "You've exceeded the number of available seats. Please adjust your ticket count."
        }
    }

    func reserveSelectedSeats() {
        for seatID in selectedSeats {
            if let index = seats.firstIndex(where: { $0.id == seatID }) {
                seats[index] = seats[index].withStatus(.reserved)
            }
        }
        errorMessage = nil
        saveReservations()
        addOrder()

        selectedSeats.removeAll()
        adultTickets = 0
        childTickets = 0
        errorMessage = nil
    }

    private func saveReservations() {
        let reservedSeats = seats.filter { $0.status == .reserved }.map { $0.id }
        UserDefaults.standard.set(reservedSeats, forKey: "reservedSeats_\(currentTimeSlot.id)")
    }

    func isSeatSelectionValid() -> Bool {
        return selectedSeats.count == totalTicketCount
    }

    private func addOrder() {
        guard selectedSeats.count == totalTicketCount else {
            errorMessage = "Please select exactly \(totalTicketCount) seats."
            return
        }

        let movie = CinemaModelManager.shared.movie(forID: currentTimeSlot.movieId)
        let session = CinemaModelManager.shared.session(forID: currentTimeSlot.sessionId)

        guard let movie = movie, let session = session else {
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
            tickets.append(Ticket(type: .adult, quantity: 1, price: adultTicketPrice, seatID: selectedSeatIDs[i]))
        }
        for i in 0..<childTickets {
            tickets.append(Ticket(type: .child, quantity: 1, price: childTicketPrice, seatID: selectedSeatIDs[adultTickets + i]))
        }

        let newOrder = Order(movie: movie, session: session, timeSlot: currentTimeSlot, tickets: tickets)
        CinemaModelManager.shared.addOrder(newOrder)
    }

    func loadReservations() {
        if let reservedSeats = UserDefaults.standard.array(forKey: "reservedSeats_\(currentTimeSlot.id)") as? [String] {
            for seatID in reservedSeats {
                if let index = seats.firstIndex(where: { $0.id == seatID }) {
                    seats[index] = seats[index].withStatus(.reserved)
                }
            }
        }
    }

    func cancelSeat(seatID: String) {
        if let index = seats.firstIndex(where: { $0.id == seatID }) {
            seats[index].status = .available
        }
    }

    @objc private func handleSeatStatusUpdate(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let timeSlotID = userInfo["timeSlotID"] as? String, timeSlotID == currentTimeSlot.id else {
            return
        }
        self.seats = currentTimeSlot.seats
    }
}

extension Notification.Name {
    static let seatStatusUpdated = Notification.Name("seatStatusUpdated")
}
