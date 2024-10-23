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
                temperatureBoard
                hourlyForecastBoard
            }
        }
        .onAppear() {
            viewModel.onAppear()
        }
    }
}

// MARK: - private View
extension MainView {
    /// 최상단 기온 보드
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
    
    /// 2번째 시간별 기온 보드
    private var hourlyForecastBoard: some View {
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
                    ForEach(viewModel.hourlyIndices, id: \.self) { idx in
                        VStack(spacing: 4) {
                            Text(idx == 0 ? "지금" : "\(viewModel.hourlyTimes[idx])")
                                .font(.subheadline)
                            Image(viewModel.hourlyWeatherIcon[idx])
                                .font(.largeTitle)
                            Text("\(viewModel.hourlyTemparatures[idx])°")
                                .font(.headline)
                        }
                        .padding(.horizontal, 8)
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
