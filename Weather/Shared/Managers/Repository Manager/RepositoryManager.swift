//
//  RepositoryManager.swift
//  Weather
//
//  Created by hanjongwoo on 10/21/24.
//

import Foundation

enum RepositoryManager {
    static let weatherRepository: WeatherRepository = WeatherRepository()
}

extension RepositoryManager {
    static func clear() {
        weatherRepository.clear()
    }
}
