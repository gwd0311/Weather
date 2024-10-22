import Foundation

// MARK: - Response
public struct WeatherForecastResponse: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: CurrentWeatherData
    let hourly: [HourlyWeatherData]
    let daily: [DailyWeatherData]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, hourly, daily
    }
}

// MARK: - 현재날씨
public struct CurrentWeatherData: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double?
    let weather: [WeatherCondition]
    let rain: RainVolume?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp, pressure, humidity, dewPoint, uvi, clouds, visibility
        case feelsLike = "feels_like"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, rain
    }
}

// MARK: - 시간당 날씨
public struct HourlyWeatherData: Codable {
    let dt: Int
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double?
    let weather: [WeatherCondition]
    let pop: Double
    let rain: RainVolume?

    enum CodingKeys: String, CodingKey {
        case dt, temp, pressure, humidity, dewPoint, uvi, clouds, visibility, pop
        case feelsLike = "feels_like"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, rain
    }
}

// MARK: - 일간 날씨
public struct DailyWeatherData: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let summary: String
    let temp: TemperatureData
    let feelsLike: FeelsLikeTemperature
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double?
    let weather: [WeatherCondition]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset, moonPhase, summary
        case temp, feelsLike, pressure, humidity, dewPoint, windSpeed, windDeg, windGust, weather, clouds, pop, rain, uvi
    }
}

// MARK: - 온도
public struct TemperatureData: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

// MARK: - 체감온도
public struct FeelsLikeTemperature: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}

// MARK: - 날씨상태
public struct WeatherCondition: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: - 시간당 강수량
public struct RainVolume: Codable {
    let oneHour: Double?
    let threeHours: Double?

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHours = "3h"
    }
}

