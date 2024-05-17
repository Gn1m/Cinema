// Seat.swift
// Cinema
//
// Created by Ming Z on 5/5/2024.
//

import Foundation


enum SeatStatus {
    case available, reserved  // The seat can either be available or reserved.
}


class Seat: Identifiable {
    let row: String  // Row identifier for the seat (e.g., "A", "B").
    let number: Int  // Seat number within the row.
    private var _status: SeatStatus  // Internal state of the seat (available or reserved).

    /// Default rows and number of seats per row in a typical cinema.
    static let defaultRows = ["A", "B", "C", "D", "E"]
    static let defaultSeatsPerRow = 10

 
    init(row: String, number: Int, status: SeatStatus = .available) {
        self.row = row
        self.number = number
        self._status = status
    }

    /// Public accessor and mutator for the seat's status.
    var status: SeatStatus {
        get { return _status }
        set { _status = newValue }
    }

    /// Computed property that generates a unique identifier for the seat.
    var id: String {
        return "\(row)\(number)"
    }

    /// Returns a new seat instance with the specified status.
    func withStatus(_ newStatus: SeatStatus) -> Seat {
        return Seat(row: self.row, number: self.number, status: newStatus)
    }

    /// Generates a collection of default seats for a cinema.
    static func generateSeats() -> [Seat] {
        var seats = [Seat]()
        for row in defaultRows {
            for number in 1...defaultSeatsPerRow {
                seats.append(Seat(row: row, number: number, status: .available))
            }
        }
        return seats
    }
}
