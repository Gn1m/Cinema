//
//  MovieDetailView.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject private var viewModel: MovieDetailViewModel
    @State private var selectedDate: Date = Calendar.current.startOfDay(for: Date())
    let movieID: String

    init(movieID: String) {
        self.movieID = movieID
        self._viewModel = ObservedObject(wrappedValue: MovieDetailViewModel(movieID: movieID))
    }

    var sessionDates: [Date] {
        let dates = viewModel.sessions.map { Calendar.current.startOfDay(for: $0.date) }
        return Array(Set(dates)).sorted()
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
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

                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.movie?.name ?? "")
                        .font(.largeTitle)
                        .bold()

                    Text(viewModel.movie?.description ?? "")
                        .font(.body)

                    if let trailerLink = viewModel.movie?.trailerLink {
                        Link("Watch Trailer", destination: trailerLink)
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.top, 8)
                    }
                }
                .padding(.horizontal)

                Divider()

                if let releasedMovie = viewModel.movie as? ReleasedMovie {
                    VStack(alignment: .leading) {
                        Text("Sessions")
                            .font(.headline)
                            .padding(.horizontal)

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
                }
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMovie = SampleMoviesProvider.getComingSoonMovies().first!
        MovieDetailView(movieID: sampleMovie.id)
    }
}
