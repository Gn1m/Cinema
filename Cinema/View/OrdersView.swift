//
//  OrdersView.swift
//  Cinema
//
//  Created by Ming Z on 6/5/2024.
//

// OrdersView.swift
import SwiftUI

struct OrdersView: View {
    @State private var selectedMovie: Movie?
    @State private var selectedSession: Session?
    @State private var selectedSeats: [Seat] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Order details")
                    .font(.title)
                
                NavigationLink(destination: TicketDetailView(movie: selectedMovie, session: selectedSession, seats: selectedSeats)) {
                    Text("Your ordered ticket")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Orders")
        }
    }
}

struct TicketDetailView: View {
    var movie: Movie?
    var session: Session?
    var seats: [Seat]?

    var body: some View {
        VStack {
            Text("Ticket Detail View").font(.title)
            if let movie = movie, let session = session, let seats = seats {
                List {
                    Section(header: Text("Movie")) {
                        Text(movie.name)
                    }
                    Section(header: Text("Session")) {
                        Text(session.id)
                    }
                    Section(header: Text("Selected Seats")) {
                        ForEach(seats, id: \.id) { seat in
                            Text("Row: \(seat.row), Number: \(seat.number)")
                        }
                    }
                }
            } else {
                Text("Ticket information not available.")
            }
        }
        .navigationBarTitle("Ticket Details", displayMode: .inline)
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}



