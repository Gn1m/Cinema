//
//  SeatSelectionViewModel.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation
import Combine

/// ViewModel for managing the seat selection for movie sessions.
class SeatSelectionViewModel: ObservableObject {
    @Published var currentTimeSlot: TimeSlot
    @Published var seats: [Seat]
    @Published var selectedSeats: Set<String> = []
    @Published var adultTickets: Int = 0
    @Published var childTickets: Int = 0
    @Published var errorMessage: String?

    /// Initializes the ViewModel with the specific time slot.
    /// - Parameter timeSlotID: Identifier for the time slot.
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

    /// Toggles the selection state of a seat.
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

    /// Reserves the selected seats.
    func reserveSelectedSeats() {
        guard selectedSeats.count == totalTicketCount else {
            errorMessage = "Please select exactly \(totalTicketCount) seats."
            return
        }
        seats.indices.forEach { if selectedSeats.contains(seats[$0].id) { seats[$0].status = .reserved } }
        clearSelection()
    }

    /// Clears the current seat selection.
    private func clearSelection() {
        selectedSeats.removeAll()
        adultTickets = 0
        childTickets = 0
        errorMessage = nil
    }

    /// Saves seat reservations to UserDefaults.
    private func saveReservations() {
        let reservedSeats = seats.filter { $0.status == .reserved }.map { $0.id }
        UserDefaults.standard.set(reservedSeats, forKey: "reservedSeats_\(currentTimeSlot.id)")
    }

    /// Loads seat reservations from UserDefaults.
    private func loadReservations() {
        if let reservedSeats = UserDefaults.standard.array(forKey: "reservedSeats_\(currentTimeSlot.id)") as? [String] {
            seats.indices.forEach { if reservedSeats.contains(seats[$0].id) { seats[$0].status = .reserved } }
        }
    }

    /// Handles updates to seat statuses from external notifications.
    @objc private func handleSeatStatusUpdate(_ notification: Notification) {
        if let userInfo = notification.userInfo,
           let timeSlotID = userInfo["timeSlotID"] as? String,
           timeSlotID == currentTimeSlot.id {
            self.seats = currentTimeSlot.seats
        }
    }

    /// Computed property for total ticket count.
    var totalTicketCount: Int {
        adultTickets + childTickets
    }

    /// Computed property for total price of selected tickets.
    var totalPrice: Double {
        let adultPrice = Double(adultTickets) * TicketType.adult.defaultPrice
        let childPrice = Double(childTickets) * TicketType.child.defaultPrice
        return adultPrice + childPrice
    }
}

/// Extension for notification names related to the seat selection.
extension Notification.Name {
    static let seatStatusUpdated = Notification.Name("seatStatusUpdated")
}
