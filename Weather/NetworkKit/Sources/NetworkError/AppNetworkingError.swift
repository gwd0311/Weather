//
//  File.swift
//  NetworkKit
//
//  Created by hanjongwoo on 10/21/24.
//

import Foundation

public enum AppNetworkingError: Error {
    case badURLString(urlString: String)
    case badURL(urlString: String)
    case badResponse(urlString: String)
    case responseError(urlString: String, data: Data?, status: Int)
}

extension AppNetworkingError: LocalizedError {
     public var errorDescription: String? {
        switch self {
        case .badURLString(let urlString):
            return "badURLString: \(urlString)"
        case .badURL(let urlString):
            return "badURL: \(urlString)"
        case .badResponse(let urlString):
            return "badResponse: \(urlString)"
        case .responseError(let urlString, _, let status):
            return "responseError: \(urlString), status: \(status)"
        }
    }
}
