// TimeSlot.swift
// Cinema
//
// Created by Ming Z on 13/5/2024.
//

import Foundation

/// Represents a specific time slot within a session for showing a movie.
class TimeSlot: Identifiable {
    private let _id: String // Unique identifier for the time slot.
    private var _startTime: Date // Start time of the time slot.
    private var _endTime: Date // End time of the time slot.
    private var _seats: [Seat] // List of seats available for booking within this time slot.
    private let _sessionId: String // Identifier for the session this time slot belongs to.
    private let _movieId: String // Identifier for the movie being shown in this time slot.

    /// Initializes a new time slot with all necessary details.
    /// - Parameters:
    ///   - id: Unique identifier for the time slot.
    ///   - startTime: Start time of the time slot.
    ///   - endTime: End time of the time slot.
    ///   - seats: Array of seats available during this time slot.
    ///   - sessionId: ID of the session that includes this time slot.
    ///   - movieId: ID of the movie shown during this time slot.
    init(id: String, startTime: Date, endTime: Date, seats: [Seat], sessionId: String, movieId: String) {
        self._id = id
        self._startTime = startTime
        self._endTime = endTime
        self._seats = seats
        self._sessionId = sessionId
        self._movieId = movieId
    }

    // MARK: - Public accessors and mutators

    /// Public accessor for the time slot's ID.
    var id: String {
        return _id
    }

    /// Public accessors and mutators for the time slot's start time.
    var startTime: Date {
        get { return _startTime }
        set { _startTime = newValue }
    }

    /// Public accessors and mutators for the time slot's end time.
    var endTime: Date {
        get { return _endTime }
        set { _endTime = newValue }
    }

    /// Public accessors and mutators for the seats available during the time slot.
    var seats: [Seat] {
        get { return _seats }
        set { _seats = newValue }
    }

    /// Public accessor for the session ID to which the time slot belongs.
    var sessionId: String {
        return _sessionId
    }

    /// Public accessor for the movie ID associated with this time slot.
    var movieId: String {
        return _movieId
    }
}
