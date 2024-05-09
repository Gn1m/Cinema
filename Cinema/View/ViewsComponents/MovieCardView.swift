//
//  MovieCardView.swift
//  Cinema
//
//  Created by Ming Z on 9/5/2024.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie

    var body: some View {
        VStack {
            // Ensure movie.imageURL is valid
            if let url = movie.imageURL {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 220)
                        .clipped()
                } placeholder: {
                    Color.gray
                        .frame(width: 150, height: 220)
                }
            } else {
                // Fallback view when imageURL is not provided
                Color.gray
                    .frame(width: 150, height: 220)
            }

            Text(movie.name)
                .font(.headline)
                .multilineTextAlignment(.center)
                .frame(width: 150)
                .padding(.top, 8)
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .padding(.vertical, 8)
    }
}
