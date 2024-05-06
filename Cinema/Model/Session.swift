//
//  Session.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation

class Session: Identifiable {
    // 唯一标识符
    private let _id: String
    // 开始日期（天）
    private var _date: Date
    // 多个时间段
    private var _timeSlots: [TimeSlot]

    // 初始化器
    init(id: String, date: Date, timeSlots: [TimeSlot]) {
        self._id = id
        self._date = date
        self._timeSlots = timeSlots
    }

    // 对外公开的标识符属性
    var id: String {
        return _id
    }

    // 日期的 getter 和 setter
    var date: Date {
        get { return _date }
        set { _date = newValue }
    }

    // 时间段数组的 getter 和 setter
    var timeSlots: [TimeSlot] {
        get { return _timeSlots }
        set { _timeSlots = newValue }
    }
}


// 单个时间段的放映信息
class TimeSlot: Identifiable {
    private let _id: String
    private var _startTime: Date
    private var _endTime: Date
    private var _seats: [Seat]

    init(id: String, startTime: Date, endTime: Date, seats: [Seat]) {
        self._id = id
        self._startTime = startTime
        self._endTime = endTime
        self._seats = seats
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
}
