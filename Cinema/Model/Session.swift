//
//  Session.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation

class Session: Identifiable {
    private let _id: String
    private var _date: Date
    private var _timeSlots: [TimeSlot]
    private let _movieId: String  // Storing the ID of the movie associated with the session

    init(id: String, date: Date, timeSlots: [TimeSlot], movieId: String) {
        self._id = id
        self._date = date
        self._timeSlots = timeSlots
        self._movieId = movieId
    }

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

    // Accessor for movieId
    var movieId: String {
        return _movieId
    }
}

import Foundation

class TimeSlot: Identifiable {
    private let _id: String
    private var _startTime: Date
    private var _endTime: Date
    private var _seats: [Seat]
    private let _sessionId: String  // ID of the session this time slot belongs to
    private let _movieId: String    // ID of the movie this time slot is showing

    init(id: String, startTime: Date, endTime: Date, seats: [Seat], sessionId: String, movieId: String) {
        self._id = id
        self._startTime = startTime
        self._endTime = endTime
        self._seats = seats
        self._sessionId = sessionId
        self._movieId = movieId
    }

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

    // Exposing the session ID publicly
    var sessionId: String {
        return _sessionId
    }

    // Exposing the movie ID publicly
    var movieId: String {
        return _movieId
    }
}
