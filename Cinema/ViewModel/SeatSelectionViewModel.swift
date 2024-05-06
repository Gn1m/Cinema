//
//  SeatSelectionViewModel.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//


// SeatSelectionViewModel.swift
import Foundation
import SwiftUI

class SeatSelectionViewModel: ObservableObject {
    @Published var seats: [Seat]
    @Published var selectedSeats: Set<String> = []
    @Published var adultTickets: Int = 0
    @Published var childTickets: Int = 0
    
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
        if selectedSeats.contains(seatID) {
            selectedSeats.remove(seatID)
        } else if selectedSeats.count < totalTicketCount {
            selectedSeats.insert(seatID)
        }
    }
    
    func reserveSelectedSeats() {
        for seat in seats where selectedSeats.contains(seat.id) {
            seat.status = .reserved
        }
        selectedSeats.removeAll()
    }
}
