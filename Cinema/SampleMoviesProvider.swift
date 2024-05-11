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
        var movies = [ReleasedMovie]()
        let movieDetails = [
            ("1", "The Matrix", "In a dystopian future where virtual reality dominates, hacker Neo joins the resistance against the controllers behind the simulated reality."),
            ("2", "The Matrix Reloaded", "Neo and the resistance join forces again to fight off the machines, attempting to decipher the virtual world's code and prevent humanity's extinction."),
            ("3", "Inception", "A thief with the ability to enter people's dreams and steal secrets must pull off the ultimate heist: planting an idea into someone's mind."),
            ("4", "Interstellar", "A team of astronauts travels through a wormhole in search of a new home for humanity.")
        ]

        for (id, name, description) in movieDetails {
            let sessions = generateSessions(for: Date(), movieId: id)
            let movie = ReleasedMovie(
                id: id,
                name: name,
                description: description,
                sessions: sessions,
                trailerLink: URL(string: "https://www.youtube.com/watch?v=video_id_\(id)"),
                imageURL: URL(string: "https://imageurl.com/movie_\(id).jpg")
            )
            movies.append(movie)
        }
        return movies
    }




    // Method to return a list of ComingSoonMovies
    static func getComingSoonMovies() -> [ComingSoonMovie] {
        return [
            ComingSoonMovie(
                id: "2",
                name: "The Matrix Reloaded",
                description: "Neo and the resistance join forces again to fight off the machines, attempting to decipher the virtual world's code and prevent humanity's extinction.",
                trailerLink: URL(string: "https://www.youtube.com/watch?v=kYzz0FSgpSU"),
                imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/4/40/Matrix_reloaded_ver5.jpg")
            ),
            ComingSoonMovie(
                id: "3",
                name: "Inception",
                description: "A thief with the ability to enter people's dreams and steal secrets must pull off the ultimate heist: planting an idea into someone's mind.",
                trailerLink: URL(string: "https://www.youtube.com/watch?v=YoHD9XEInc0"),
                imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/7/7f/Inception_ver3.jpg")
            ),
            ComingSoonMovie(
                id: "4",
                name: "Interstellar",
                description: "A team of astronauts travels through a wormhole in search of a new home for humanity.",
                trailerLink: URL(string: "https://www.youtube.com/watch?v=zSWdZVtXT7E"),
                imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/b/bc/Interstellar_film_poster.jpg")
            )
        ]
    }


}
