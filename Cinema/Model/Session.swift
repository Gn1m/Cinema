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
    private let _movieId: String

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

    var movieId: String {
        return _movieId
    }
}
