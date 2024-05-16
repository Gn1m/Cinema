// Seat.swift
// Cinema
//
// Created by Ming Z on 5/5/2024.
//

import Foundation

/// Enum representing the status of a cinema seat.
enum SeatStatus {
    case available, reserved  // The seat can either be available or reserved.
}

/// Represents an individual seat in a cinema.
class Seat: Identifiable {
    let row: String  // Row identifier for the seat (e.g., "A", "B").
    let number: Int  // Seat number within the row.
    private var _status: SeatStatus  // Internal state of the seat (available or reserved).

    /// Default rows and number of seats per row in a typical cinema.
    static let defaultRows = ["A", "B", "C", "D", "E"]
    static let defaultSeatsPerRow = 10

    /// Initializes a new seat with the given properties.
    /// - Parameters:
    ///   - row: The row identifier for the seat.
    ///   - number: The number of the seat within the row.
    ///   - status: The initial status of the seat, defaulting to available.
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
    /// - Parameter newStatus: The new status to assign to the seat.
    /// - Returns: A new `Seat` object with the updated status.
    func withStatus(_ newStatus: SeatStatus) -> Seat {
        return Seat(row: self.row, number: self.number, status: newStatus)
    }

    /// Generates a collection of default seats for a cinema.
    /// - Returns: An array of `Seat` objects with default settings.
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
