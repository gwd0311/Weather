import Foundation

// MARK: - WeatherResponse
public struct WeatherResponse: Codable, Sendable {
    public let lat, lon: Double
    public let timezone: String
    public let timezoneOffset: Int
    public let current: WeatherData
    public let hourly: [WeatherData]
    public let daily: [DailyWeatherData]

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
    public let main: WeatherDescription
    public let description: WeatherDetailDescription
    public let icon: IconInfo
}

public enum WeatherDescription: String, Codable, Sendable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case drizzle = "Drizzle"
    case thunderstorm = "Thunderstorm"
    case snow = "Snow"
    case mist = "Mist"
    case haze = "Haze"
    case fog = "Fog"
    case dust = "Dust"
    case ash = "Ash"
    case squall = "Squall"
    case tornado = "Tornado"
    case sand = "Sand"
    
    public var description: String {
        switch self {
            case .clear: return "맑음"
            case .clouds: return "흐림"
            case .rain: return "비"
            case .drizzle: return "이슬비"
            case .thunderstorm: return "뇌우"
            case .snow: return "눈"
            case .mist: return "안개"
            case .haze: return "안개"
            case .fog: return "안개"
            case .dust: return "먼지"
            case .ash: return "먼지"
            case .squall: return "소나기"
            case .tornado: return "태풍"
            case .sand: return "먼지"
        }
    }
}

public enum WeatherDetailDescription: String, Codable, Sendable {
    case thunderstormWithLightRain = "thunderstorm with light rain"
    case thunderstormWithRain = "thunderstorm with rain"
    case thunderstormWithHeavyRain = "thunderstorm with heavy rain"
    case lightThunderstorm = "light thunderstorm"
    case thunderstorm = "thunderstorm"
    case heavyThunderstorm = "heavy thunderstorm"
    case raggedThunderstorm = "ragged thunderstorm"
    case thunderstormWithLightDrizzle = "thunderstorm with light drizzle"
    case thunderstormWithDrizzle = "thunderstorm with drizzle"
    case thunderstormWithHeavyDrizzle = "thunderstorm with heavy drizzle"

    case lightIntensityDrizzle = "light intensity drizzle"
    case drizzle = "drizzle"
    case heavyIntensityDrizzle = "heavy intensity drizzle"
    case lightIntensityDrizzleRain = "light intensity drizzle rain"
    case drizzleRain = "drizzle rain"
    case heavyIntensityDrizzleRain = "heavy intensity drizzle rain"
    case showerRainAndDrizzle = "shower rain and drizzle"
    case heavyShowerRainAndDrizzle = "heavy shower rain and drizzle"
    case showerDrizzle = "shower drizzle"
    
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case heavyIntensityRain = "heavy intensity rain"
    case veryHeavyRain = "very heavy rain"
    case extremeRain = "extreme rain"
    case freezingRain = "freezing rain"
    case lightIntensityShowerRain = "light intensity shower rain"
    case showerRain = "shower rain"
    case heavyIntensityShowerRain = "heavy intensity shower rain"
    case raggedShowerRain = "ragged shower rain"

    case lightSnow = "light snow"
    case snow = "snow"
    case heavySnow = "heavy snow"
    case sleet = "sleet"
    case lightShowerSleet = "light shower sleet"
    case showerSleet = "shower sleet"
    case lightRainAndSnow = "light rain and snow"
    case rainAndSnow = "rain and snow"
    case lightShowerSnow = "light shower snow"
    case showerSnow = "shower snow"
    case heavyShowerSnow = "heavy shower snow"

    case mist = "mist"
    case smoke = "smoke"
    case haze = "haze"
    case dust = "dust"
    case sandDustWhirls = "sand/dust whirls"
    case fog = "fog"
    case sand = "sand"
    case volcanicAsh = "volcanic ash"
    case squalls = "squalls"
    case tornado = "tornado"

    case clearSky = "clear sky"

    case fewClouds = "few clouds"
    case scatteredClouds = "scattered clouds"
    case brokenClouds = "broken clouds"
    case overcastClouds = "overcast clouds"
}


public enum IconInfo: String, Codable, Sendable {
    case the01D = "01d"
    case the01N = "01n"
    case the02D = "02d"
    case the02N = "02n"
    case the03D = "03d"
    case the03N = "03n"
    case the04D = "04d"
    case the04N = "04n"
    case the09D = "09d"
    case the09N = "09n"
    case the10D = "10d"
    case the10N = "10n"
    case the11D = "11d"
    case the11N = "11n"
    case the13D = "13d"
    case the13N = "13n"
    case the50D = "50d"
    case the50N = "50n"
}


// MARK: - DailyWeatherData
public struct DailyWeatherData: Codable, Sendable {
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

