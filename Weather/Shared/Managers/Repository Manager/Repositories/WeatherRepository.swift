//
//  PhotoRepository.swift
//  Weather
//
//  Created by hanjongwoo on 10/21/24.
//

//import PhotosKit
import BaseKit
import NetworkKit
import SwiftUI

final class WeatherRepository: BaseRepository {
    
    @Published private(set) var currentWeather: WeatherData? = nil
    @Published private(set) var dailyWeathers: [DailyWeatherData] = []
    
    private let weatherService: WeatherServiceProtocol
    
    init(
        weatherService: WeatherServiceProtocol = ServiceManager.shared.weatherService
    ) {
        self.weatherService = weatherService
        super.init()
        configure()
    }
    
    private func configure() {}
    
    override func clear() {
        currentWeather = nil
    }
}

// MARK: - Public Functions
extension WeatherRepository {
    func fetchWeatherData(lat: Double, lon: Double) {
        setIsLoading(true)
        Task { @MainActor in
            let result = await self.weatherService.getCurrentWeatherInfo(lat: lat, lon: lon)
            switch result {
            case .success(let data):
                self.currentWeather = data.current
                self.dailyWeathers = data.daily
                print(dailyWeathers.first?.temp.max)
                self.setIsLoading(false)
            case .failure:
                self.setIsLoading(false)
            }
        }
    }
    
    func setupInitialWeatherData() {
        fetchWeatherData(lat: 36.783611, lon: 127.004173)
    }
}
