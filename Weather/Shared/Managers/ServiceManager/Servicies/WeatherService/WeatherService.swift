//
//  File.swift
//  NetworkKit
//
//  Created by hanjongwoo on 10/21/24.
//

import Foundation
import CoreLocation
import NetworkKit
import BaseKit

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

protocol WeatherServiceProtocol: BaseServiceProtocol {
    func getCurrentWeatherInfo(lat: Double, lon: Double) async -> Result<WeatherResponse, NetworkError>
    func getCityList() async -> Result<[City], AppError>
}

final class WeatherService: WeatherServiceProtocol {
    
    private let client: RequestSendable
    private let locationManager = CLLocationManager()

    var headers: [String : String] {
        return defaultHeaders
    }
    
    init(client: RequestSendable) {
        self.client = client
    }
    
    func getCurrentWeatherInfo(lat: Double, lon: Double) async -> Result<WeatherResponse, NetworkError> {
                
        let request: WeatherRequest = .getCurrentWeatherInfo(lat: lat, lon: lon, headers: headers)
        
        do {
            let data = try await client.send(request: request)
            let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
            
            return .success(response)
        } catch {
            debug("Error decoding JSON: \(error)")
            return .failure(NetworkError.from(error))
        }
    }
    
    func getCityList() async -> Result<[City], AppError> {
        guard let url1 = Bundle.main.url(forResource: "citylist1", withExtension: "json"),
              let url2 = Bundle.main.url(forResource: "citylist2", withExtension: "json") else {
            debug("One or both citylist.json files not found")
            return .failure(.fetchCityListError)
        }
        
        do {
            async let data1 = Data(contentsOf: url1)
            async let data2 = Data(contentsOf: url2)
            
            let (cityList1, cityList2) = try await (
                JSONDecoder().decode([City].self, from: data1),
                JSONDecoder().decode([City].self, from: data2)
            )
            
            debug("City list 1: \(cityList1.count)")
            debug("City list 2: \(cityList2.count)")
            
            let cityList = cityList1 + cityList2
            debug("Successfully loaded city list with \(cityList.count) entries")
            debug("CityListSample: \(cityList[0..<5])")
            return .success(cityList)
        } catch {
            debug("Error decoding city lists: \(error)")
            return .failure(.fetchCityListError)
        }
    }
}
