//
//  City.swift
//  Weather
//
//  Created by hanjongwoo on 10/24/24.
//

import Foundation

// MARK: - City
struct City: Codable, Sendable, Hashable {
    let id: Int
    let name, country: String
    let coord: Coord
    
    static let asan: City = .init(id: 1839726, name: "Asan", country: "KR", coord: .init(lon: 127.004173, lat: 36.783611))
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}

// MARK: - Coord
struct Coord: Codable, Sendable, Hashable {
    let lon, lat: Double
}

