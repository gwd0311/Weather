//
//  HourlyForecastBoard.swift
//  Weather
//
//  Created by hanjongwoo on 10/23/24.
//

import SwiftUI

struct HourlyForecastBoard: View {
    
    @StateObject var viewModel: MainViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("돌풍의 풍속은 최대 \(viewModel.maxWindSpeed)m/s 입니다.")
                .foregroundStyle(.white)
                .fontSized(10)
                .padding(.bottom, 8)
            LineDivider()
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(viewModel.hourlyIndices, id: \.self) { idx in
                        HourlyItemView(
                            hour: idx == 0 ? "지금" : viewModel.hourlyTimes[idx],
                            icon: viewModel.hourlyWeatherIcon[idx],
                            temperature: viewModel.hourlyTemparatures[idx]
                        )
                    }
                }
                .frame(height: 100)
                .padding(.horizontal, 0)
            }
        }
        .padding()
        .background(Color.theme.boardColor)
        .cornerRadius(10)
        .padding()
    }
}
