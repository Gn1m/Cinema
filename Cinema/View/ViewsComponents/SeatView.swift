//
//  SeatView.swift
//  Cinema
//
//  Created by Ming Z on 9/5/2024.
//

import SwiftUI

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
