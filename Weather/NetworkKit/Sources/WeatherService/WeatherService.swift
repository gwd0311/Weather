//
//  File.swift
//  NetworkKit
//
//  Created by hanjongwoo on 10/21/24.
//

import Foundation
import CoreLocation

private enum WeatherRequest {
    case getCurrentWeatherInfo(lat: Double, lon: Double, headers: HTTPHeaders)
}

// MARK: - Requestable

extension WeatherRequest: Requestable {
    
    var urlString: String {
        switch self {
        case .getCurrentWeatherInfo(lat: let lat, lon: let lon, headers: _):
            return "\(BASE_URL)?lat=\(lat)&lon=\(lon)&appid=\(API_KEY)"
        }
    }
    
    var query: HTTPQuery? {
        switch self {
        case .getCurrentWeatherInfo(_, _, let headers):
            return headers
        }
    }

    var headers: HTTPHeaders? {
        switch self {
        default:
            return nil
        }
    }

    var method: HTTPMethod? {
        switch self {
        case .getCurrentWeatherInfo:
            return .get
        }
    }

    var body: HTTPBody? {
        return nil
    }

    var contentType: HTTPContentType? {
        return .json
    }
}

public protocol WeatherServiceProtocol: BaseServiceProtocol {
    func getCurrentWeatherInfo() async -> Result<CurrentWeatherResponse, AppError>
}

public final class WeatherService: WeatherServiceProtocol {
    private let client: RequestSendable
    private let locationManager = CLLocationManager()

    public var headers: [String : String] {
        return defaultHeaders
    }
    
    public init(client: RequestSendable) {
        self.client = client
    }
}
