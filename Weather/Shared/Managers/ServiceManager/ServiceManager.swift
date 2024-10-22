//
//  ServiceManager.swift
//  Weather
//
//  Created by hanjongwoo on 10/21/24.
//

import Foundation
import NetworkKit

class ServiceManager {
    static let shared: ServiceManager = ServiceManager()
    
    private(set) lazy var client: NetworkClient = {
        NetworkClient()
    }()
    
    private(set) lazy var weatherService: WeatherServiceProtocol = WeatherService(client: client)
}
