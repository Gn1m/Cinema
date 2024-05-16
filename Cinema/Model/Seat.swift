// Seat.swift
// Cinema
//
// Created by Ming Z on 5/5/2024.
//

import Foundation

// Enum representing seat status
enum SeatStatus {
    case available, reserved
}

// Seat class represents a seat in the cinema
class Seat: Identifiable {
    let row: String
    let number: Int
    private var _status: SeatStatus

    // Static properties for default rows and seats per row
    static let defaultRows = ["A", "B", "C", "D", "E"]
    static let defaultSeatsPerRow = 10

    // Initializer for Seat
    init(row: String, number: Int, status: SeatStatus = .available) {
        self.row = row
        self.number = number
        self._status = status
    }

    // Computed property for encapsulating the private status variable
    var status: SeatStatus {
        get { return _status }
        set { _status = newValue }
    }

    // Computed property for generating seat ID
    var id: String {
        return "\(row)\(number)"
    }

    // Method to create a new Seat with updated status
    func withStatus(_ newStatus: SeatStatus) -> Seat {
        return Seat(row: self.row, number: self.number, status: newStatus)
    }

    // Static method to generate default seats
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
