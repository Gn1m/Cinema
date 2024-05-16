//
//  Seat.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.

import Foundation

enum SeatStatus {
    case available, reserved
}

class Seat: Identifiable {
    let row: String
    let number: Int
    private var _status: SeatStatus

    static let defaultRows = ["A", "B", "C", "D", "E"]
    static let defaultSeatsPerRow = 10

    init(row: String, number: Int, status: SeatStatus = .available) {
        self.row = row
        self.number = number
        self._status = status
    }

    var status: SeatStatus {
        get { return _status }
        set { _status = newValue }
    }

    var id: String {
        return "\(row)\(number)"
    }

    func withStatus(_ newStatus: SeatStatus) -> Seat {
        return Seat(row: self.row, number: self.number, status: newStatus)
    }

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
