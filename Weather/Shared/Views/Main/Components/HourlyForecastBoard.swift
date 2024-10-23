//
//  HourlyForecastBoard.swift
//  Weather
//
//  Created by hanjongwoo on 10/23/24.
//

import SwiftUI

struct HourlyForecastBoard: View {
    let hourlyIndices: [Int]
    let hourlyTimes: [String]
    let hourlyWeatherIcon: [String]
    let hourlyTemparatures: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("돌풍의 풍속은 최대 4m/s 입니다.")
                .foregroundStyle(.white)
                .fontSized(10)
                .padding(.bottom, 8)
            Rectangle()
                .foregroundStyle(Color.theme.lineColor)
                .frame(height: 1)
                .padding(.bottom, 8)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(hourlyIndices, id: \.self) { idx in
                        HourlyItemView(
                            hour: hourlyTimes[idx],
                            icon: hourlyWeatherIcon[idx],
                            temperature: hourlyTemparatures[idx]
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
