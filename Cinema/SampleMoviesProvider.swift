//
//  sampleMovies.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation

class SampleMoviesProvider {
    static func getSampleMovies() -> [Movie] {
        let today = Date()
        let futureDays = 4 // 安排未来 4 天的电影场次
        
        // 预定义每天不同的时间段
        let allDailyTimeSlots = [
            ["10:00", "13:00", "16:00", "19:00"], // Day 1
            ["10:30", "13:30", "16:30", "19:30", "22:30"], // Day 2
            ["11:00", "14:00", "17:00", "20:00"], // Day 3
            ["09:00", "12:00", "15:00", "18:00", "21:00"] // Day 4
        ]
        
        // 将字符串时间转换为当天的 `Date` 对象
        func getDateTime(baseDate: Date, timeString: String) -> Date {
            var calendar = Calendar.current
            calendar.timeZone = TimeZone.current
            var components = calendar.dateComponents([.year, .month, .day], from: baseDate)
            let timeComponents = timeString.split(separator: ":").map { Int($0) }
            components.hour = timeComponents[0]
            components.minute = timeComponents[1]
            return calendar.date(from: components) ?? baseDate
        }

        // 为特定的日期生成 `TimeSlot`
        func generateTimeSlots(for baseDate: Date, times: [String]) -> [TimeSlot] {
            var timeSlots = [TimeSlot]()
            for timeString in times {
                let startTime = getDateTime(baseDate: baseDate, timeString: timeString)
                let endTime = startTime.addingTimeInterval(2 * 60 * 60) // 电影持续 2 小时
                let slotID = "\(timeString) - \(endTime)"
                timeSlots.append(TimeSlot(id: slotID, startTime: startTime, endTime: endTime, seats: generateSeats()))
            }
            return timeSlots
        }

        // 生成每天的 `Session`
        func generateSessions(for baseDate: Date) -> [Session] {
            var sessions = [Session]()
            for day in 0..<futureDays {
                let currentDay = Calendar.current.date(byAdding: .day, value: day, to: baseDate)!
                let sessionID = "Day \(day + 1)"
                // 根据天数索引获取不同的时间段表
                let times = allDailyTimeSlots[day % allDailyTimeSlots.count]
                let timeSlots = generateTimeSlots(for: currentDay, times: times)
                sessions.append(Session(id: sessionID, date: currentDay, timeSlots: timeSlots))
            }
            return sessions
        }

        // 示例座位生成器
        func generateSeats() -> [Seat] {
            let rows = ["A", "B", "C", "D", "E"] // 5 排
            let seatsPerRow = 10 // 每排 10 个座位

            var seats = [Seat]()
            
            // 遍历行并创建每排的座位
            for row in rows {
                for number in 1...seatsPerRow {
                    let seat = Seat(row: row, number: number, status: .available)
                    seats.append(seat)
                }
            }

            return seats
        }

        // 使用同一组 `sessions` 为所有电影提供相同场次
        let commonSessions = generateSessions(for: today)

        // 创建示例电影数据
        return [
            Movie(
                id: "1",
                name: "The Matrix",
                description: "In a dystopian future where virtual reality dominates, hacker Neo joins the resistance against the controllers behind the simulated reality.",
                sessions: commonSessions,
                trailerLink: URL(string: "https://www.youtube.com/watch?v=vKQi3bBA1y8"),
                imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/c/c1/The_Matrix_Poster.jpg")
            ),
            Movie(
                id: "2",
                name: "The Matrix Reloaded",
                description: "Neo and the resistance join forces again to fight off the machines, attempting to decipher the virtual world's code and prevent humanity's extinction.",
                sessions: commonSessions,
                trailerLink: URL(string: "https://www.youtube.com/watch?v=kYzz0FSgpSU"),
                imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/thumb/4/40/Matrix_reloaded_ver5.jpg/220px-Matrix_reloaded_ver5.jpg")
            ),
            Movie(
                id: "3",
                name: "The Matrix Revolutions",
                description: "Neo realizes his abilities and joins his allies in the final fight against the machines to decide the fate of both the real and virtual worlds.",
                sessions: commonSessions,
                trailerLink: URL(string: "https://www.youtube.com/watch?v=hMbexEPAOQI"),
                imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/thumb/3/34/Matrix_revolutions_ver7.jpg/220px-Matrix_revolutions_ver7.jpg")
            ),
            Movie(
                id: "4",
                name: "Kung Fu Panda 4",
                description: "Follow Po on his wide-eyed adventures in ancient China, whose love of kung fu is matched only by an insatiable appetite.",
                sessions: commonSessions,
                trailerLink: URL(string: "https://www.youtube.com/watch?v=example"),
                imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/thumb/3/3b/Kung_Fu_Panda_4_Poster.jpg/220px-Kung_Fu_Panda_4_Poster.jpg")
            )
        ]
    }
}
