//
//  ContentView.swift
//  Weather
//
//  Created by hanjongwoo on 10/21/24.
//

import SwiftUI
import NetworkKit
import BaseKit

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                temperatureBoard
                hourlyForecastBoard
            }
        }
        .onAppear() {
            viewModel.onAppear()
        }
    }
}

extension MainView {
    private var temperatureBoard: some View {
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
    
    private var hourlyForecastBoard: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("돌풍의 풍속은 최대 4m/s 입니다.")
                .foregroundStyle(.white)
                .fontSized(10)
                .padding(.bottom, 8)
            Rectangle()
                .foregroundStyle(Color.theme.lineColor)
                .frame(height: 1)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(1..<14, id: \.self) { hour in
                        VStack(spacing: 4) {
                            Text(hour == 1 ? "지금" : "\(hour)시간 후")
                                .font(.subheadline)
                            Image(systemName: "sun.max.fill")
                                .font(.largeTitle)
                            Text("\(Int.random(in: -10...5))°")
                                .font(.headline)
                        }
                        .offset(x: -20)
                        .padding()
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .background(Color.theme.boardColor)
        .cornerRadius(10)
        .padding()
    }
}

// MARK: - ViewModel
final class MainViewModel: BaseViewModel {
    
    @Published private(set) var currentWeather: WeatherData? = nil
    @Published private(set) var dailyWeathers: [DailyWeatherData] = []
    
    private let weatherRepository: WeatherRepository
    
    init(_ weatherRepository: WeatherRepository = RepositoryManager.weatherRepository) {
        self.weatherRepository = weatherRepository
        super.init()
        configure()
    }
    
    override func configure() {
        weatherRepository.$currentWeather
            .receive(on: DispatchQueue.main)
            .assign(to: &$currentWeather)
        
        weatherRepository.$dailyWeathers
            .assign(to: &$dailyWeathers)
        
        weatherRepository.$isLoading
            .receive(on: DispatchQueue.main)
            .assign(to: &$isLoading)
    }
    
    override func handleError(_ error: AppError) {
        debug(error)
    }
    
    func handleError(_ error: Error) {
        if let appError = error as? AppError {
            handleError(appError)
        } else {
            handleError(.unknown)
        }
    }
}

// MARK: - Computed Properties
extension MainViewModel {
    
#warning("도시이름 파싱하고 변경하기")
    var cityName: String {
        "Seoul"
    }
    
    /// 현재 기온
    var weatherDescription: String {
        currentWeather?.weather.first?.main.description ?? "날씨 정보 없음"
    }
    
    /// 현재 날씨상태
    var tempDescription: String {
        if let temp = currentWeather?.temp {
            return "\(Int(temp - 273.15))°"
        } else {
            return "-"
        }
    }
    
    /// 최고기온
    var maxTempDescription: String {
        if let maxTemp = dailyWeathers.first?.temp.max {
            return "최고: \(Int(maxTemp - 273.15))°"
        } else {
            return "-"
        }
    }
    
    /// 최저기온
    var minTempDescription: String {
        if let minTemp = dailyWeathers.first?.temp.min {
            return "최저: \(Int(minTemp - 273.15))°"
        } else {
            return "-"
        }
    }
}

// MARK: - Public Functions
extension MainViewModel {
    
    func onAppear() {
        weatherRepository.fetchWeatherData(lat: 36.77, lon: 127.37)
    }
    
}

#Preview {
    MainView()
}
