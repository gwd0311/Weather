//
//  FiveDaysForcastItem.swift
//  Weather
//
//  Created by hanjongwoo on 10/23/24.
//

import SwiftUI

struct DayForecastItem: View {
    let title: String
    let icon: String
    let minTemp: String
    let maxTemp: String

    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .foregroundStyle(.white)
                .frame(width: 30, alignment: .leading)
                .padding(.trailing, 80)
            Image(icon)
                .resizable()
                .frame(width: 28, height: 28)
            Spacer()
            HStack(spacing: 0) {
                Text("최소: \(minTemp)")
                    .foregroundStyle(.white)
                    .opacity(0.8)
                    .padding(.trailing, 4)
                Text("최대: \(maxTemp)")
                    .foregroundStyle(.white)
            }
        }
    }
}
