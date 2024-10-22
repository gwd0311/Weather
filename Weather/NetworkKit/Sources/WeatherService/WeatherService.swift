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
    func getCurrentWeatherInfo(lat: Double, lon: Double) async -> Result<WeatherForecastResponse, NetworkError>
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
    
    public func getCurrentWeatherInfo(lat: Double, lon: Double) async -> Result<WeatherForecastResponse, NetworkError> {
        
        let request: WeatherRequest = .getCurrentWeatherInfo(lat: lat, lon: lon, headers: headers)
        
        do {
            let data = try await client.send(request: request)
            let response = try JSONDecoder().decode(BaseResponse<WeatherForecastResponse>.self, from: data)
            
            if response.status, let responseData = response.data {
                return .success(responseData)
            } else {
                return .failure(.generic(error: response.error))
            }
        } catch {
            return .failure(NetworkError.from(error))
        }
    }
}
