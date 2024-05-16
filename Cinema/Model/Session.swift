// Session.swift
// Cinema
//
// Created by Ming Z on 5/5/2024.
//

import Foundation

/// Represents a specific showing of a movie, including its date, time slots, and associated movie ID.
class Session: Identifiable {
    private let _id: String // Unique identifier for the session.
    private var _date: Date // Date on which the session occurs.
    private var _timeSlots: [TimeSlot] // Collection of time slots during which the movie is shown.
    private let _movieId: String // Identifier for the associated movie.

    /// Initializes a new session with its essential details.
    /// - Parameters:
    ///   - id: Unique identifier for the session.
    ///   - date: Date of the session.
    ///   - timeSlots: List of time slots for this session.
    ///   - movieId: ID of the movie shown in this session.
    init(id: String, date: Date, timeSlots: [TimeSlot], movieId: String) {
        self._id = id
        self._date = date
        self._timeSlots = timeSlots
        self._movieId = movieId
    }

    // MARK: - Public accessors and mutators

    /// Public accessor for the session's ID.
    var id: String {
        return _id
    }

    /// Public accessors and mutators for the session's date.
    var date: Date {
        get { return _date }
        set { _date = newValue }
    }

    /// Public accessors and mutators for the session's time slots.
    var timeSlots: [TimeSlot] {
        get { return _timeSlots }
        set { _timeSlots = newValue }
    }

    /// Public accessor for the session's associated movie ID.
    var movieId: String {
        return _movieId
    }
}
