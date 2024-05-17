import SwiftUI

/// View for displaying detailed information about a specific movie.
struct MovieDetailView: View {
    @ObservedObject private var viewModel: MovieDetailViewModel // ViewModel managing the data for the movie detail.
    @State private var selectedDate: Date = Calendar.current.startOfDay(for: Date()) // State to manage the selected session date for viewing times.
    @State private var errorMessage: String? // State for displaying error messages.
    let movieID: String // ID of the movie being displayed.
    
    
    init(movieID: String) {
        self.movieID = movieID
        self._viewModel = ObservedObject(wrappedValue: MovieDetailViewModel(movieID: movieID))
    }
    
    /// Computes the unique session dates from the sessions associated with the movie.
    var sessionDates: [Date] {
        let dates = viewModel.sessions.map { Calendar.current.startOfDay(for: $0.date) }
        return Array(Set(dates)).sorted()
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Image display for the movie.
                if let movie = viewModel.movie, let imageURL = movie.imageURL {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: UIScreen.main.bounds.width * 0.56)
                            .clipped()
                            .ignoresSafeArea(edges: .top)
                    } placeholder: {
                        Color.gray
                            .frame(height: UIScreen.main.bounds.width * 0.56)
                            .ignoresSafeArea(edges: .top)
                    }
                }
                
                // Textual details of the movie.
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.movie?.name ?? "")
                        .font(.largeTitle)
                        .bold()
                    
                    Text(viewModel.movie?.description ?? "")
                        .font(.body)
                    
                    // Link to the movie's trailer.
                    if let trailerLink = viewModel.movie?.trailerLink {
                        Link("Watch Trailer", destination: trailerLink)
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.top, 8)
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                // Conditional display of session details.
                if let releasedMovie = viewModel.movie as? ReleasedMovie {
                    VStack(alignment: .leading) {
                        Text("Sessions")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        // Horizontal scroll view for selecting session dates.
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(sessionDates, id: \.self) { date in
                                    Button(action: {
                                        selectedDate = date
                                    }) {
                                        Text(date, style: .date)
                                            .padding()
                                            .background(selectedDate == date ? Color.red : Color.gray)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Grid for selecting specific session times.
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
                            ForEach(viewModel.sessions.filter { session in
                                Calendar.current.isDate(session.date, inSameDayAs: selectedDate)
                            }) { session in
                                ForEach(session.timeSlots) { slot in
                                    NavigationLink(destination: SeatSelectionView(timeSlotID: slot.id, allTimeSlots: session.timeSlots)) {
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
                } else if viewModel.movie is ComingSoonMovie {
                    // Message for "Coming Soon" movies with no sessions.
                    VStack(alignment: .leading) {
                        Text("This movie is coming soon. Sessions will be available once it is released.")
                            .font(.headline)
                            .padding()
                    }
                }
                
                // Error message display.
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
        .onAppear {
            // Load movie details and handle any potential errors.
            if viewModel.movie == nil {
                errorMessage = "Failed to load movie details."
            }
        }
    }
}

/// Preview provider for SwiftUI previews in Xcode.
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMovie = SampleMoviesProvider.getComingSoonMovies().first!
        MovieDetailView(movieID: sampleMovie.id)
    }
}
