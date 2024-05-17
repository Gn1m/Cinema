// TimeSlot.swift
// Cinema
//
// Created by Ming Z on 13/5/2024.
//

import Foundation


class TimeSlot: Identifiable {
    private let _id: String // Unique identifier for the time slot.
    private var _startTime: Date // Start time of the time slot.
    private var _endTime: Date // End time of the time slot.
    private var _seats: [Seat] // List of seats available for booking within this time slot.
    private let _sessionId: String // Identifier for the session this time slot belongs to.
    private let _movieId: String // Identifier for the movie being shown in this time slot.

    init(id: String, startTime: Date, endTime: Date, seats: [Seat], sessionId: String, movieId: String) {
        self._id = id
        self._startTime = startTime
        self._endTime = endTime
        self._seats = seats
        self._sessionId = sessionId
        self._movieId = movieId
    }

    // accessors and mutators

    
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
