//
//  TemparatureBoard.swift
//  Weather
//
//  Created by hanjongwoo on 10/23/24.
//

import SwiftUI

struct TemperatureBoard: View {
    let cityName: String
    let tempDescription: String
    let weatherDescription: String
    let maxTempDescription: String
    let minTempDescription: String

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 2) {
                Text(cityName)
                    .fontSized(40)
                    .padding(.bottom, 2)
                Text(tempDescription)
                    .fontSized(70)
                Text(weatherDescription)
                    .fontSized(35)
            }
            .foregroundColor(.white)
            HStack(spacing: 10) {
                Text(maxTempDescription)
                Text("|")
                Text(minTempDescription)
            }
            .foregroundColor(.white)
        }
    }
}
