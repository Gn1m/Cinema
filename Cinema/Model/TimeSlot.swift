// TimeSlot.swift
// Cinema
//
// Created by Ming Z on 13/5/2024.
//

import Foundation

// TimeSlot class represents a specific timeslot within a session
class TimeSlot: Identifiable {
    private let _id: String
    private var _startTime: Date
    private var _endTime: Date
    private var _seats: [Seat]
    private let _sessionId: String
    private let _movieId: String

    // Initializer for TimeSlot
    init(id: String, startTime: Date, endTime: Date, seats: [Seat], sessionId: String, movieId: String) {
        self._id = id
        self._startTime = startTime
        self._endTime = endTime
        self._seats = seats
        self._sessionId = sessionId
        self._movieId = movieId
    }

    // Computed properties for encapsulating the private variables
    var id: String {
        return _id
    }

    var startTime: Date {
        get { return _startTime }
        set { _startTime = newValue }
    }

    var endTime: Date {
        get { return _endTime }
        set { _endTime = newValue }
    }

    var seats: [Seat] {
        get { return _seats }
        set { _seats = newValue }
    }

    var sessionId: String {
        return _sessionId
    }

    var movieId: String {
        return _movieId
    }
}
