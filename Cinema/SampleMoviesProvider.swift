//
//  sampleMovies.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import Foundation

class SampleMoviesProvider {
    // Helper function to convert string time to Date
    static func getDateTime(baseDate: Date, timeString: String) -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        var components = calendar.dateComponents([.year, .month, .day], from: baseDate)
        let timeComponents = timeString.split(separator: ":").map { Int($0)! }
        components.hour = timeComponents[0]
        components.minute = timeComponents[1]
        return calendar.date(from: components) ?? baseDate
    }
    
    // Helper function to generate a list of time slots for a specific day
    static func generateTimeSlots(for baseDate: Date, times: [String], sessionId: String, movieId: String) -> [TimeSlot] {
        var timeSlots = [TimeSlot]()
        for timeString in times {
            let startTime = getDateTime(baseDate: baseDate, timeString: timeString)
            let endTime = startTime.addingTimeInterval(2 * 60 * 60) // Movie duration: 2 hours
            let slotID = "Session\(sessionId)-Movie\(movieId)-\(timeString)-\(endTime)"
            let seats = Seat.generateSeats()
            timeSlots.append(TimeSlot(id: slotID, startTime: startTime, endTime: endTime, seats: seats, sessionId: sessionId, movieId: movieId))
        }
        return timeSlots
    }
    
    // Helper function to generate a list of sessions for multiple future days
    static func generateSessions(for baseDate: Date, movieId: String) -> [Session] {
        let futureDays = 4
        let allDailyTimeSlots = [
            ["10:00", "13:00", "16:00", "19:00"],
            ["10:30", "13:30", "16:30", "19:30", "22:30"],
            ["11:00", "14:00", "17:00", "20:00"],
            ["09:00", "12:00", "15:00", "18:00", "21:00"]
        ]
        
        var sessions = [Session]()
        for day in 0..<futureDays {
            let currentDay = Calendar.current.date(byAdding: .day, value: day, to: baseDate)!
            let sessionID = "Day\(day + 1)-Movie\(movieId)"
            let times = allDailyTimeSlots[day % allDailyTimeSlots.count]
            let timeSlots = generateTimeSlots(for: currentDay, times: times, sessionId: sessionID, movieId: movieId)
            sessions.append(Session(id: sessionID, date: currentDay, timeSlots: timeSlots, movieId: movieId))
        }
        return sessions
    }
    
    // Method to return a list of ReleasedMovies
    static func getReleasedMovies() -> [ReleasedMovie] {
        let movieDetails = [
            ReleasedMovie(
                id: "1",
                name: "The Matrix",
                description: "In a dystopian future where virtual reality dominates, hacker Neo joins the resistance against the controllers behind the simulated reality.",
                sessions: generateSessions(for: Date(), movieId: "1"),
                trailerLink: URL(string: "https://www.youtube.com/watch?v=vKQi3bBA1y8")!,
                imageURL: URL(string: "https://m.media-amazon.com/images/I/51EG732BV3L.jpg")!
            ),
            ReleasedMovie(
                id: "2",
                name: "The Matrix Reloaded",
                description: "Neo and the resistance join forces again to fight off the machines, attempting to decipher the virtual world's code and prevent humanity's extinction.",
                sessions: generateSessions(for: Date(), movieId: "2"),
                trailerLink: URL(string: "https://www.youtube.com/watch?v=zsgrsiZoymA")!,
                imageURL: URL(string: "https://m.media-amazon.com/images/I/51oBxmV-dML.jpg")!
            ),
            ReleasedMovie(
                id: "3",
                name: "The Lord of the Rings: The Fellowship of the Ring",
                description: "A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.",
                sessions: generateSessions(for: Date(), movieId: "3"),
                trailerLink: URL(string: "https://www.youtube.com/watch?v=V75dMMIW2B4")!,
                imageURL: URL(string: "https://m.media-amazon.com/images/I/51Qvs9i5a%2BL.AC.jpg")!
            )
        ]
        
        return movieDetails
    }
    
    
    
    // Method to return a list of ComingSoonMovies
    static func getComingSoonMovies() -> [ComingSoonMovie] {
        return [
            ComingSoonMovie(
                id: "2",
                name: "The Matrix Reloaded",
                description: "Neo and the resistance join forces again to fight off the machines, attempting to decipher the virtual world's code and prevent humanity's extinction.",
                trailerLink: URL(string: "https://www.youtube.com/watch?v=zsgrsiZoymA")!,
                imageURL: URL(string: "https://m.media-amazon.com/images/I/51oBxmV-dML.jpg")!
            ),
            ComingSoonMovie(
                id: "3",
                name: "The Lord of the Rings: The Fellowship of the Ring",
                description: "A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.",
                trailerLink: URL(string: "https://www.youtube.com/watch?v=V75dMMIW2B4")!,
                imageURL: URL(string: "https://m.media-amazon.com/images/I/51Qvs9i5a%2BL.AC.jpg")!
            )
        ]
    }
}
