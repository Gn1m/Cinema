//
//  MovieDetailView.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import SwiftUI

// View to display movie details
struct MovieDetailView: View {
    @StateObject private var viewModel: MovieDetailViewModel // ViewModel to manage state and business logic
    @State private var selectedDate: Date = Calendar.current.startOfDay(for: Date()) // State to track the selected date for sessions
    let movie: Movie // Movie object to display details
    
    // Initializer to set the movie and initialize the ViewModel
    init(movie: Movie) {
        self.movie = movie
        self._viewModel = StateObject(wrappedValue: MovieDetailViewModel(movie: movie))
    }
    
    // Computed property to get unique session dates
    var sessionDates: [Date] {
        let dates = viewModel.sessions.map { Calendar.current.startOfDay(for: $0.date) }
        return Array(Set(dates)).sorted()
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Movie poster section
                if let imageURL = movie.imageURL {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: UIScreen.main.bounds.width * 0.56) // 16:9 aspect ratio
                            .alignmentGuide(.top) { d in d[.top] } // Align to the top
                            .clipped()
                            .ignoresSafeArea(edges: .top)
                    } placeholder: {
                        Color.gray
                            .frame(height: UIScreen.main.bounds.width * 0.56)
                            .ignoresSafeArea(edges: .top)
                    }
                }
                
                // Movie information section
                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.name)
                        .font(.largeTitle)
                        .bold()
                    
                    Text(movie.description)
                        .font(.body)
                    
                    if let trailerLink = movie.trailerLink {
                        Link("Watch Trailer", destination: trailerLink)
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.top, 8)
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                // Display different content based on movie type
                if let releasedMovie = movie as? ReleasedMovie {
                    // Unique content for ReleasedMovie type
                    VStack(alignment: .leading) {
                        Text("Sessions")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        // Date selection
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                // Generate date buttons using sessionDates
                                ForEach(sessionDates, id: \.self) { date in
                                    Button(action: {
                                        selectedDate = date
                                    }) {
                                        Text(date, style: .date)
                                            .padding()
                                            .background(selectedDate == date ? Color.red : Color.gray) // Conditional styling
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Filter and display time slots for the selected date
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
                            ForEach(viewModel.sessions.filter { session in
                                Calendar.current.isDate(session.date, inSameDayAs: selectedDate)
                            }) { session in
                                ForEach(session.timeSlots) { slot in
                                    NavigationLink(destination: SeatSelectionView(initialTimeSlot: slot, allTimeSlots: session.timeSlots)) {
                                        VStack {
                                            Text(slot.startTime, style: .time)
                                        }
                                        .padding()
                                        .background(Color.red)
                                        .cornerRadius(20)
                                        .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

// Preview provider for MovieDetailView
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMovie = SampleMoviesProvider.getComingSoonMovies().first!
        MovieDetailView(movie: sampleMovie)
    }
}
