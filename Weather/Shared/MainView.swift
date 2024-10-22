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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear {
            viewModel.onAppear()
        }
        .padding()
    }
}

// MARK: - ViewModel
final class MainViewModel: BaseViewModel {
    
    @Published private(set) var currentWeather: WeatherData? = nil
    
    private let weatherRepository: WeatherRepository
    
    init(_ weatherRepository: WeatherRepository = RepositoryManager.weatherRepository) {
        self.weatherRepository = weatherRepository
        super.init()
    }
    
    override func configure() {
        weatherRepository.$isLoading
            .assign(to: &$isLoading)
        weatherRepository.$currentWeather
            .assign(to: &$currentWeather)
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

// MARK: - Public Functions
extension MainViewModel {
    
    func onAppear() {
        weatherRepository.fetchWeatherData(lat: 36.77, lon: 127.37)
    }
    
}

#Preview {
    MainView()
}
