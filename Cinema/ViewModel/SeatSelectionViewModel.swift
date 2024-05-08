//
//  SeatSelectionViewModel.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation
import SwiftUI

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
    }

    // 验证所选座位是否与购买票数相符
    func isSeatSelectionValid() -> Bool {
        return selectedSeats.count == totalTicketCount
    }

    private func saveReservations() {
        let reservedSeats = seats.filter { $0.status == .reserved }.map { $0.id }
        UserDefaults.standard.set(reservedSeats, forKey: "reservedSeats_\(currentTimeSlot.id)")
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
}
