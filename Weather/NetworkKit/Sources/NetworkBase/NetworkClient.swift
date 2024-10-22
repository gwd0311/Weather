//
//  File.swift
//  NetworkKit
//
//  Created by hanjongwoo on 10/21/24.
//

import Foundation
import Combine
import BaseKit

public protocol RequestSendable {
    func send(request: Requestable) -> AnyPublisher<Data, Error>
    func send(request: Requestable) async throws -> Data
}

public final class NetworkClient: RequestSendable {
    
    public init() {}
    
    public func send(request: Requestable) -> AnyPublisher<Data, Error> {
        let urlRequest: URLRequest
        do {
            urlRequest = try request.build()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse else {
                    throw AppNetworkingError.badResponse(urlString: request.urlString)
                }
                print(httpResponse.statusCode)
                print(element.data.debugDescription)
                
                guard request.successStatusCodeRange.contains(httpResponse.statusCode) else {
                    throw AppNetworkingError.responseError(urlString: request.urlString, data: element.data, status: httpResponse.statusCode)
                }
                return element.data
            }
            .tryCatch { error -> AnyPublisher<Data, Error> in
                throw error
            }
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    public func send(request: Requestable) async throws -> Data {
        let urlRequest: URLRequest = try request.build()

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw AppNetworkingError.badResponse(urlString: request.urlString)
        }

        print(httpResponse.statusCode)
        print(data.count)

        guard request.successStatusCodeRange.contains(httpResponse.statusCode) else {
            throw AppNetworkingError.responseError(urlString: request.urlString, data: data, status: httpResponse.statusCode)
        }

        return data
    }
}
