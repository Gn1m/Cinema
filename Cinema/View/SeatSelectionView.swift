import SwiftUI

// View to handle seat selection for a movie
struct SeatSelectionView: View {
    @StateObject private var viewModel: SeatSelectionViewModel // ViewModel to manage state and business logic
    @State private var navigateToMainView = false // State to control navigation to the main view
    private let allTimeSlots: [TimeSlot] // All available time slots for the movie

    // Initializer to set the initial time slot and all available time slots
    init(initialTimeSlot: TimeSlot, allTimeSlots: [TimeSlot]) {
        _viewModel = StateObject(wrappedValue: SeatSelectionViewModel(initialTimeSlot: initialTimeSlot))
        self.allTimeSlots = allTimeSlots
    }

    // Computed property to get unique seat rows
    private var rows: [String] {
        Set(viewModel.seats.map { $0.row }).sorted()
    }

    // Computed property to get seat columns
    private var columns: [Int] {
        let maxNumber = viewModel.seats.map { $0.number }.max() ?? 0
        return Array(1...maxNumber)
    }

    var body: some View {
        VStack {
            // Ticket selection section
            VStack(alignment: .leading, spacing: 10) {
                Text("Select Tickets")
                    .font(.headline)

                HStack {
                    Text("Adult Tickets:")
                    Stepper(value: $viewModel.adultTickets, in: 0...10) {
                        Text("\(viewModel.adultTickets)")
                    }
                }

                HStack {
                    Text("Child Tickets:")
                    Stepper(value: $viewModel.childTickets, in: 0...10) {
                        Text("\(viewModel.childTickets)")
                    }
                }

                Text("Total Price: $\(viewModel.totalPrice, specifier: "%.2f")")
                    .font(.subheadline)
                    .bold()
                    .padding(.top, 8)
            }
            .padding(.horizontal)
            .padding(.top, 16)

            Divider()
                .padding(.vertical, 8)

            // Label indicating front of the screen
            Text("Front of Screen")
                .font(.headline)
                .bold()
                .padding(.bottom, 8)

            // Grid layout for seat selection
            HStack(alignment: .top) {
                // Row labels on the left
                VStack(alignment: .trailing) {
                    ForEach(rows, id: \.self) { row in
                        Text(row)
                            .fontWeight(.bold)
                            .frame(width: 20, height: 25)
                            .padding(.vertical, 4)
                    }
                }
                .padding(.trailing, 8)

                // Seat grid
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(rows, id: \.self) { row in
                        HStack(spacing: 2) {
                            ForEach(columns, id: \.self) { column in
                                // Add a wider gap to simulate the aisle
                                if column == 3 || column == 9 {
                                    Spacer()
                                        .frame(width: 20)
                                }

                                let seatID = "\(row)\(column)"
                                let seat = viewModel.seats.first { $0.id == seatID }
                                SeatView(seat: seat, isSelected: viewModel.selectedSeats.contains(seatID)) {
                                    if seat?.status == .available {
                                        viewModel.toggleSeatSelection(seatID)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()

            // Display error message if any
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 8)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
            }

            // Proceed button to reserve seats and navigate
            Button("Proceed") {
                if viewModel.isSeatSelectionValid() {
                    viewModel.reserveSelectedSeats()
                    navigateToMainView = true
                } else {
                    viewModel.errorMessage = "Please select exactly \(viewModel.totalTicketCount) seats."
                }
            }
            .padding()
            .background(viewModel.isSeatSelectionValid() ? Color.black : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.top, 8)
            .disabled(!viewModel.isSeatSelectionValid())

            // NavigationLink to ContentView (Main View) with back button hidden
            NavigationLink(destination: ContentView()
                            .navigationBarBackButtonHidden(true),
                           isActive: $navigateToMainView) {
                EmptyView()
            }
        }
        .onAppear {
            // Load existing reservations when the view appears
            viewModel.loadReservations()
        }
    }
}

