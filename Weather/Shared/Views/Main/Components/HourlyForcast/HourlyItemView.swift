//
//  HourlyItemView.swift
//  Weather
//
//  Created by hanjongwoo on 10/23/24.
//

import SwiftUI

struct HourlyItemView: View {
    let hour: String
    let icon: String
    let temperature: String

    var body: some View {
        VStack(spacing: 4) {
            Text(hour)
                .font(.subheadline)
            Image(icon)
                .font(.largeTitle)
            Text("\(temperature)°")
                .font(.headline)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 8)
    }
}
