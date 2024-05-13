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

    init(initialTimeSlot: TimeSlot) {
        self.currentTimeSlot = initialTimeSlot
        self.seats = initialTimeSlot.seats
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
        addOrder()  // Automatically add order after seats are reserved
        
        // Clear current selections and reset ticket counts after successful order addition
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

        // Fetch the necessary movie and session directly from currentTimeSlot
        let movie = CinemaModelManager.shared.movie(forID: currentTimeSlot.movieId)
        let session = CinemaModelManager.shared.session(forID: currentTimeSlot.sessionId)

        guard let movie = movie, let session = session else {
            errorMessage = "Error fetching movie or session details."
            return
        }

        // Ensure we have exact number of seats selected as tickets
        if selectedSeats.count != adultTickets + childTickets {
            errorMessage = "Number of selected seats does not match the number of tickets."
            return
        }

        // Create tickets with seat IDs
        var tickets: [Ticket] = []
        let selectedSeatIDs = Array(selectedSeats)
        for i in 0..<adultTickets {
            tickets.append(Ticket(type: .adult, quantity: 1, price: adultTicketPrice, seatID: selectedSeatIDs[i]))
        }
        for i in 0..<childTickets {
            tickets.append(Ticket(type: .child, quantity: 1, price: childTicketPrice, seatID: selectedSeatIDs[adultTickets + i]))
        }

        // Create and add the order with the correct time slot
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
    
}
