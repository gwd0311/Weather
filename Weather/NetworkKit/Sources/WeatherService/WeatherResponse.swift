import Foundation

// MARK: - WeatherResponse
public struct WeatherResponse: Codable, Sendable {
    public let lat, lon: Double
    public let timezone: String
    public let timezoneOffset: Int
    public let current: WeatherData
    public let hourly: [WeatherData]
    public let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, hourly, daily
    }
}

// MARK: - WeatherData
public struct WeatherData: Codable, Sendable {
    public let dt: Int
    public let sunrise, sunset: Int?
    public let temp, feelsLike: Double
    public let pressure, humidity: Int
    public let dewPoint, uvi: Double
    public let clouds, visibility: Int
    public let windSpeed: Double
    public let windDeg: Int
    public let windGust: Double?
    public let weather: [WeatherInfo]
    public let rain: Rain?
    public let pop: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, rain, pop
    }
}

// MARK: - Rain
public struct Rain: Codable, Sendable {
    public let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - WeatherInfo
public struct WeatherInfo: Codable, Sendable {
    public let id: Int
    public let main: Main
    public let description: Description
    public let icon: Icon
}

public enum Description: String, Codable, Sendable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case overcastClouds = "overcast clouds"
}

public enum Icon: String, Codable, Sendable {
    case the01D = "01d"
    case the01N = "01n"
    case the04D = "04d"
    case the04N = "04n"
    case the10D = "10d"
    case the10N = "10n"
}

public enum Main: String, Codable, Sendable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

// MARK: - Daily
public struct Daily: Codable, Sendable {
    public let dt, sunrise, sunset, moonrise: Int
    public let moonset: Int
    public let moonPhase: Double
    public let summary: String
    public let temp: Temp
    public let feelsLike: FeelsLike
    public let pressure, humidity: Int
    public let dewPoint, windSpeed: Double
    public let windDeg: Int
    public let windGust: Double
    public let weather: [WeatherInfo]
    public let clouds: Int
    public let pop: Double
    public let rain: Double?
    public let uvi: Double

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case summary, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, rain, uvi
    }
}

// MARK: - FeelsLike
public struct FeelsLike: Codable, Sendable {
    public let day, night, eve, morn: Double
}

// MARK: - Temp
public struct Temp: Codable, Sendable {
    public let day, min, max, night, eve, morn: Double
}

