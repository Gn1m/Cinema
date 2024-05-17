// Session.swift
// Cinema
//
// Created by Ming Z on 5/5/2024.
//

import Foundation

// a specific showing of a movie, including its date, time slots, and associated movie ID.
class Session: Identifiable {
    private let _id: String // Unique identifier for the session.
    private var _date: Date // Date on which the session occurs.
    private var _timeSlots: [TimeSlot] // Collection of time slots during which the movie is shown.
    private let _movieId: String // Identifier for the associated movie.

    init(id: String, date: Date, timeSlots: [TimeSlot], movieId: String) {
        self._id = id
        self._date = date
        self._timeSlots = timeSlots
        self._movieId = movieId
    }

    // accessors and mutators

   
    var id: String {
        return _id
    }

   
    var date: Date {
        get { return _date }
        set { _date = newValue }
    }

    
    var timeSlots: [TimeSlot] {
        get { return _timeSlots }
        set { _timeSlots = newValue }
    }

    
    var movieId: String {
        return _movieId
    }
}
