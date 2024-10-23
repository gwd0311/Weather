//
//  TemparatureBoard.swift
//  Weather
//
//  Created by hanjongwoo on 10/23/24.
//

import SwiftUI

struct TemperatureBoard: View {
    
    @StateObject var viewModel: MainViewModel

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 2) {
                Text(viewModel.cityName)
                    .fontSized(40)
                    .padding(.bottom, 2)
                Text(viewModel.tempDescription)
                    .fontSized(70)
                Text(viewModel.weatherDescription)
                    .fontSized(35)
            }
            .foregroundColor(.white)
            HStack(spacing: 10) {
                Text(viewModel.maxTempDescription)
                Text("|")
                Text(viewModel.minTempDescription)
            }
            .foregroundColor(.white)
        }
    }
}
