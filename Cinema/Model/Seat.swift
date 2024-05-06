//
//  Seat.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

// Seat.swift

import Foundation

enum SeatStatus {
    case available, reserved
}

class Seat: Identifiable {
    let row: String
    let number: Int
    private var _status: SeatStatus

    init(row: String, number: Int, status: SeatStatus = .available) {
        self.row = row
        self.number = number
        self._status = status
    }

    var status: SeatStatus {
        get {
            return _status
        }
        set(newStatus) {
            _status = newStatus
        }
    }
    
    var id: String {
        // Generate a unique ID based on row and seat number
        return "\(row)\(number)"
    }
}

