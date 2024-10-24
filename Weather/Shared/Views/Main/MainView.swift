//
//  ContentView.swift
//  Weather
//
//  Created by hanjongwoo on 10/21/24.
//

import SwiftUI
import NetworkKit
import BaseKit
import MapKit

// MARK: - View
struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        BaseView(viewModel: viewModel) {
            ZStack {
                Color.theme.backgroundColor
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        SearchBar(searchText: .constant(""))
                            .disabled(true)
                            .onTapGesture {
                                viewModel.presentFullScreen(.search)
                            }
                        TemperatureBoard(viewModel: viewModel)
                        HourlyForecastBoard(viewModel: viewModel)
                        FiveDaysForecast(viewModel: viewModel)
                        WeatherMapBoard(viewModel: viewModel)
                        ClimateBoard(viewModel: viewModel)
                    }
                }
            }
            .onAppear() {
                viewModel.onAppear()
            }
        }
    }
}

// MARK: - private View
extension MainView {
    
}

// MARK: - ViewModel
final class MainViewModel: BaseViewModel {
    
    @Published private(set) var selectedCity: City = .seoul
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
        
        weatherRepository.$selectedCity
            .receive(on: DispatchQueue.main)
            .assign(to: &$selectedCity)
        
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
    
    // MARK: - TemperatureBoard
    /// 도시명
    var cityName: String { selectedCity.name }
    
    /// 위도, 경도
    var lat: Double { selectedCity.coord.lat }
    var lon: Double { selectedCity.coord.lon }
    
    /// 현재 기온
    var weatherDescription: String {
        currentWeather?.weather.first?.main.description ?? "-"
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
    
    // MARK: - HourlyForecastBoard
    
    /// 최대풍속
    var maxWindSpeed: String {
        if let windSpeed = currentWeather?.windSpeed {
            return "\(Int(windSpeed))"
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
    
    // MARK: - FiveDayForcastBoard
    /// 요일 제목
    var dayTitles: [String] {
        dailyWeathers.map { $0.dt.dayOfWeek }
    }
    
    /// 요일 기후 아이콘
    var dayIcon: [String] {
        dailyWeathers.map { $0.weather.first?.icon.rawValue ?? "-" }
    }
    
    /// 요일 최대온도
    var dayMaxTemp: [String] {
        dailyWeathers.map { $0.temp.max.kelvinToCelsius.description }
    }
    
    /// 요일 최저온도
    var dayMinTemp: [String] {
        dailyWeathers.map { $0.temp.min.kelvinToCelsius.description }
    }
    
    // MARK: - Climate Board
    
    /// 습도
    var humidity: String {
        currentWeather?.humidity.description ?? "-"
    }
    
    /// 구름
    var cloudiness: String {
        currentWeather?.clouds.description ?? "-"
    }
    
    /// 바람 속도
    var windSpeed: String {
        currentWeather?.windSpeed.description ?? "-"
    }

    /// 강풍
    var windGust: String {
        currentWeather?.windGust?.formattedWithCommas ?? "-"
    }
    
    /// 기압
    var pressure: String {
        currentWeather?.pressure.description ?? "-"
    }
}

// MARK: - Public Functions
extension MainViewModel {
    
    func onAppear() {
        weatherRepository.setupWeatherData()
        weatherRepository.setupCityList()
        CLLocationManager().requestWhenInUseAuthorization()
    }
    
}

#Preview {
    MainView()
}
