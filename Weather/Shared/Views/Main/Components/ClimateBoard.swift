//
//  ClimateBoard.swift
//  Weather
//
//  Created by hanjongwoo on 10/24/24.
//

import SwiftUI

struct ClimateBoard: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                WeatherGridBoard(
                    title: "습도",
                    content: "\(viewModel.humidity)%"
                )
                WeatherGridBoard(
                    title: "구름",
                    content: "\(viewModel.cloudiness)%"
                )
            }
            HStack(spacing: 8) {
                WeatherGridBoard(
                    title: "바람 속도",
                    content: "\(viewModel.windSpeed)m/s",
                    footer: "강풍: \(viewModel.windGust)m/s"
                )
                WeatherGridBoard(
                    title: "기압",
                    content: "\(viewModel.pressure)\nhpa"
                )
            }
        }
        .padding()
    }
}
