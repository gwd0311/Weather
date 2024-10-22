//
//  AppError.swift
//
//
//  Created by hanjongwoo on 8/6/24.
//

import Foundation

public enum NetworkError: Error {
    case generic(error: GenericError?)
    case decodingError(error: DecodingError)
    case networkingError(error: AppNetworkingError)
    case unknown
    case unexpectedError(error: Error)
}

extension NetworkError: LocalizedError {
    public static var defaultError: NetworkError {
        return .unknown
    }
    
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown Error"
        case .generic(let error):
            guard let error else { return "generic error" }
            return error.detail
        case .decodingError(let error):
            switch error {
            case .typeMismatch(_, let context), .valueNotFound(_, let context), .keyNotFound(_, let context), .dataCorrupted(let context):
                return "\(context.codingPath.last?.description ?? ""): \(context.debugDescription)"
            @unknown default:
                return error.localizedDescription
            }
        case .networkingError(let error):
            return error.localizedDescription
        case .unexpectedError(error: let error):
            return error.localizedDescription
        }
    }
    
    public static func from(_ error: Error) -> NetworkError {
        switch error {
        case let networkError as AppNetworkingError:
            return .networkingError(error: networkError)
        case let decodingError as DecodingError:
            return .decodingError(error: decodingError)
        default:
            return .unexpectedError(error: error)
        }
    }
}

public struct GenericError: Decodable, Sendable {
    public let codeStr, detail: String

    public enum CodingKeys: String, CodingKey {
        case codeStr = "code_str"
        case detail
    }
}
