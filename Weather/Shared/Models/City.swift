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
    
    static let seoul: City = .init(id: 1850147, name: "Seoul", country: "KR", coord: .init(lon: 126.978, lat: 37.561))
}

// MARK: - Coord
struct Coord: Codable, Sendable, Hashable {
    let lon, lat: Double
}

