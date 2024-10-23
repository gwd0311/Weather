//
//  ContentView.swift
//  Weather
//
//  Created by hanjongwoo on 10/21/24.
//

import SwiftUI
import NetworkKit
import BaseKit

// MARK: - View
struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                TemperatureBoard(
                    cityName: viewModel.cityName,
                    tempDescription: viewModel.tempDescription,
                    weatherDescription: viewModel.weatherDescription,
                    maxTempDescription: viewModel.maxTempDescription,
                    minTempDescription: viewModel.minTempDescription
                )
                HourlyForecastBoard(
                    hourlyIndices: viewModel.hourlyIndices,
                    hourlyTimes: viewModel.hourlyTimes,
                    hourlyWeatherIcon: viewModel.hourlyWeatherIcon,
                    hourlyTemparatures: viewModel.hourlyTemparatures
                )
            }
        }
        .onAppear() {
            viewModel.onAppear()
        }
    }
}

// MARK: - private View
extension MainView {
    
}

// MARK: - ViewModel
final class MainViewModel: BaseViewModel {
    
    @Published private(set) var currentWeather: WeatherData? = nil
    @Published private(set) var dailyWeathers: [DailyWeatherData] = []
    @Published private(set) var hourlyWeathers: [WeatherData] = []
    
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
        
        weatherRepository.$hourlyWeathers
            .receive(on: DispatchQueue.main)
            .assign(to: &$hourlyWeathers)
        
        weatherRepository.$dailyWeathers
            .receive(on: DispatchQueue.main)
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
            return "\(temp.kelvinToCelsius)°"
        } else {
            return "-"
        }
    }
    
    /// 최고기온
    var maxTempDescription: String {
        if let maxTemp = dailyWeathers.first?.temp.max {
            return "최고: \(maxTemp.kelvinToCelsius)°"
        } else {
            return "-"
        }
    }
    
    /// 최저기온
    var minTempDescription: String {
        if let minTemp = dailyWeathers.first?.temp.min {
            return "최저: \(minTemp.kelvinToCelsius)°"
        } else {
            return "-"
        }
    }
    
    /// 3시간별 인덱스
    var hourlyIndices: [Int] {
        Array(stride(from: 0, to: hourlyWeathers.count, by: 3))
    }
    
    /// 시간별 시각
    var hourlyTimes: [String] {
        hourlyWeathers.map { $0.dt.toFormattedTime }
    }
    
    /// 시간별 날씨 아이콘
    var hourlyWeatherIcon: [String] {
        hourlyWeathers.map { $0.weather.first?.icon.rawValue ?? "-" }
    }
    
    /// 시간별 기온
    var hourlyTemparatures: [String] {
        hourlyWeathers.map { $0.temp.kelvinToCelsius.description }
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
