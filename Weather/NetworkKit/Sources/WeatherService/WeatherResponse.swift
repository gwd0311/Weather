//
//  File.swift
//  NetworkKit
//
//  Created by hanjongwoo on 10/21/24.
//

import Foundation

// MARK: - 날씨예보 Response
struct ForecastResponse: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [WeatherData]
    let city: CityInfo
}

// MARK: - 날씨 데이터
struct WeatherData: Codable {
    let dt: Int
    let main: WeatherDetail
    let weather: [WeatherCondition]
    let clouds: CloudInfo
    let wind: WindInfo
    let visibility: Int
    let pop: Double
    let rain: RainInfo?
    let sys: SysInfo
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - 현재날씨 Response
struct CurrentWeatherResponse: Codable {
    let coord: Coordinate
    let weather: [WeatherCondition]
    let base: String
    let main: WeatherDetail
    let visibility: Int
    let wind: WindInfo
    let rain: RainInfo?
    let clouds: CloudInfo
    let dt: Int
    let sys: SystemInfo
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

// MARK: - 날씨 세부정보
struct WeatherDetail: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    let seaLevel: Int?
    let grndLevel: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case tempKf = "temp_kf"
    }
}

// MARK: - 날씨상태
struct WeatherCondition: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: - 구름정보
struct CloudInfo: Codable {
    let all: Int
}

// MARK: - 바람정보
struct WindInfo: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

// MARK: - 강수정보 (시간당 강수량)
struct RainInfo: Codable {
    let oneHour: Double?
    let threeHour: Double?

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHour = "3h"
    }
}

// MARK: - 주간/야간 정보
struct SysInfo: Codable {
    let pod: String    // d: 주간, n: 야간
}

// MARK: - 일출/일몰 정보
struct SystemInfo: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}

// MARK: - 도시정보
struct CityInfo: Codable {
    let id: Int
    let name: String
    let coord: Coordinate
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

// MARK: - 좌표
struct Coordinate: Codable {
    let lon: Double
    let lat: Double
}
