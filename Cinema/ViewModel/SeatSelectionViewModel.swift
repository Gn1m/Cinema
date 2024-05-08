//
//  SeatSelectionViewModel.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation
import SwiftUI

class SeatSelectionViewModel: ObservableObject {
    
    @Published var seats: [Seat]
    @Published var selectedSeats: Set<String> = []
    @Published var adultTickets: Int = 0
    @Published var childTickets: Int = 0
    @Published var errorMessage: String? // Stores error message to show the user
    
    private let adultTicketPrice: Double = 12.0
    private let childTicketPrice: Double = 8.0

    init(initialSeats: [Seat]) {
        self.seats = initialSeats
    }
    
    var totalTicketCount: Int {
        return adultTickets + childTickets
    }
    
    var totalPrice: Double {
        return (Double(adultTickets) * adultTicketPrice) + (Double(childTickets) * childTicketPrice)
    }
    
    func toggleSeatSelection(_ seatID: String) {
        // If the seat is already selected, remove it from the set
        if selectedSeats.contains(seatID) {
            selectedSeats.remove(seatID)
            errorMessage = nil
        }
        // Check if the current number of selected seats is less than the total ticket count
        else if selectedSeats.count < totalTicketCount {
            selectedSeats.insert(seatID)
            errorMessage = nil
        }
        // Otherwise, set an error message
        else {
            errorMessage = "You've exceeded the number of available seats. Please adjust your ticket count."
        }
    }

    func reserveSelectedSeats() {
        for seatID in selectedSeats {
            if let index = seats.firstIndex(where: { $0.id == seatID }) {
                // Check if the seat is already reserved
                if seats[index].status == .reserved {
                    errorMessage = "One or more seats have already been reserved. Please select different seats."
                    return
                } else {
                    seats[index] = seats[index].withStatus(.reserved)
                }
            }
        }
        // Clear any error messages after successful reservation
        errorMessage = nil
    }
}
