//
//  SeatSelectionView.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//


import SwiftUI

struct SeatSelectionView: View {
    @StateObject private var viewModel: SeatSelectionViewModel
    @State private var shouldNavigate = false
    private let allTimeSlots: [TimeSlot] // Keep this if needed for initial seat setup

    // Initializer takes the initial time slot and all available time slots
    init(initialTimeSlot: TimeSlot, allTimeSlots: [TimeSlot]) {
        _viewModel = StateObject(wrappedValue: SeatSelectionViewModel(initialTimeSlot: initialTimeSlot))
        self.allTimeSlots = allTimeSlots
    }

    private var rows: [String] {
        Set(viewModel.seats.map { $0.row }).sorted()
    }

    private var columns: [Int] {
        let maxNumber = viewModel.seats.map { $0.number }.max() ?? 0
        return Array(1...maxNumber)
    }
    
    var body: some View {
        VStack {
            // Ticket selection
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
            
            // Front of Screen label
            Text("Front of Screen")
                .font(.headline)
                .bold()
                .padding(.bottom, 8)
            
            // Grid layout for seats
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
            
            // Proceed button that reserves and navigates
            Button("Proceed") {
                viewModel.reserveSelectedSeats()
                if viewModel.errorMessage == nil {
                    shouldNavigate = true
                }
            }
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.top, 8)
            
            // NavigationLink to MainView triggered by state
            NavigationLink(destination: MainView(), isActive: $shouldNavigate) {
                EmptyView()
            }
        }
        .onAppear {
            viewModel.loadReservations()
        }
    }
}




struct SeatView: View {
    let seat: Seat?
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Rectangle()
                .fill(seatColor)
                .frame(width: 30, height: 30)
                .cornerRadius(4)
        }
        .disabled(seat?.status == .reserved)
    }
    
    private var seatColor: Color {
        if let seat = seat {
            if seat.status == .reserved {
                return .red
            } else if isSelected {
                return .green
            } else {
                return .gray
            }
        }
        return .clear
    }
}
