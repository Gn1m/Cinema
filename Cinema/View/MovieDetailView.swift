//
//  MovieDetailView.swift
//  Cinema
//
//  Created by Ming Z on 5/5/2024.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var viewModel: MovieDetailViewModel
    @State private var selectedDate: Date = Calendar.current.startOfDay(for: Date())
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        self._viewModel = StateObject(wrappedValue: MovieDetailViewModel(movie: movie))
    }
    
    // 获取 `Session` 对象中的唯一日期列表
    var sessionDates: [Date] {
        let dates = viewModel.sessions.map { Calendar.current.startOfDay(for: $0.date) }
        return Array(Set(dates)).sorted()
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // 电影海报部分
                if let imageURL = movie.imageURL {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: UIScreen.main.bounds.width * 0.56) // 16:9 比例
                            .alignmentGuide(.top) { d in d[.top] } // 使用顶部对齐
                            .clipped()
                            .ignoresSafeArea(edges: .top)
                    } placeholder: {
                        Color.gray
                            .frame(height: UIScreen.main.bounds.width * 0.56)
                            .ignoresSafeArea(edges: .top)
                    }
                }
                
                // 电影信息
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
                
                // 日期和场次
                VStack(alignment: .leading) {
                    Text("Sessions")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    // 日期选择
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            // 使用 `sessionDates` 生成日期按钮
                            ForEach(sessionDates, id: \.self) { date in
                                Button(action: {
                                    selectedDate = date
                                }) {
                                    Text(date, style: .date)
                                        .padding()
                                        .background(selectedDate == date ? Color.red : Color.gray) // 判断条件
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // 过滤并显示当天的时间段
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
                        ForEach(viewModel.sessions.filter { session in
                            Calendar.current.isDate(session.date, inSameDayAs: selectedDate)
                        }) { session in
                            ForEach(session.timeSlots) { slot in
                                NavigationLink(destination: SeatSelectionView(timeSlot: slot)) {
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

// 预览部分
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMovie = SampleMoviesProvider.getSampleMovies().first!
        MovieDetailView(movie: sampleMovie)
    }
}
