//
//  AppError.swift
//
//
//  Created by hanjongwoo on 8/6/24.
//

import Foundation

public enum AppError: Error {
    case unknown
    case unexpectedError(error: Error)
    case fetchCityListError
}

extension AppError: Throwable, LocalizedError {
    public static var defaultError: AppError {
        return .unknown
    }
    
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown Error"
        case .unexpectedError(let error):
            return error.localizedDescription
        case .fetchCityListError:
            return "CityList를 가져오는데 실패하였습니다."
        }
    }
    
    public static func from(_ error: Error) -> AppError {
        switch error {
        default:
            return .unexpectedError(error: error)
        }
    }
}

public struct GenericError: Decodable {
    public let codeStr, detail: String

    public enum CodingKeys: String, CodingKey {
        case codeStr = "code_str"
        case detail
    }
}
