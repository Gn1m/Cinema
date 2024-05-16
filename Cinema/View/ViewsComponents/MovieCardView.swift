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
            if let url = movie.imageURL {
                GeometryReader { geometry in
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    } placeholder: {
                        Color.gray
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
                .aspectRatio(2/3, contentMode: .fit)
                .frame(width: 150, height: 225)  
                .cornerRadius(8)
                .shadow(radius: 4)
            } else {
                Color.gray
                    .frame(width: 150, height: 225)
                    .cornerRadius(8)
                    .shadow(radius: 4)
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
