//
//  FiveDaysForcastBoard.swift
//  Weather
//
//  Created by hanjongwoo on 10/23/24.
//

import SwiftUI

struct FiveDaysForecast: View {
    @StateObject var viewModel: MainViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("5일간의 일기예보")
                .foregroundStyle(.white)
                .fontSized(10)
                .padding(.bottom, 8)
            LineDivider()
            
            ForEach(viewModel.dailyWeathers.indices, id: \.self) { idx in
                DayForecastItem(
                    title: idx == 0 ? "오늘" : viewModel.dayTitles[idx],
                    icon: viewModel.dayIcon[idx],
                    minTemp: "\(viewModel.dayMinTemp[idx])°",
                    maxTemp: "\(viewModel.dayMaxTemp[idx])°"
                )
                if idx != viewModel.dailyWeathers.count - 1 {
                    LineDivider()
                        .padding(.top, 8)
                }
            }
        }
        .padding()
        .background(Color.theme.boardColor)
        .cornerRadius(10)
        .padding()
    }
}
