//
//  Requestable.swift
//  NetworkKit
//
//  Created by hanjongwoo on 10/21/24.
//

import Foundation

public protocol Requestable {
    var urlString: String { get }
    var query: HTTPQuery? { get }
    var headers: HTTPHeaders? { get }
    var method: HTTPMethod? { get }
    var body: HTTPBody? { get }
    var contentType: HTTPContentType? { get }
    var successStatusCodeRange: Range<Int> { get }
    func build() throws -> URLRequest
}

public extension Requestable {
    var successStatusCodeRange: Range<Int> {
        return 200..<300
    }

    func build() throws -> URLRequest {
        // Init `URLComponents`
        guard var urlComponents: URLComponents = .init(string: urlString) else {
            throw AppNetworkingError.badURLString(urlString: urlString)
        }

        // Set `queryItems`
        if let query, !query.isEmpty {
            urlComponents.queryItems = query.map {
                URLQueryItem(name: $0, value: String(describing: $1))
            }
        }

        // Init `URL`
        guard let url: URL = urlComponents.url else {
            throw AppNetworkingError.badURL(urlString: urlString)
        }

        // Init `URLRequest`
        var urlRequest: URLRequest = .init(url: url)

        // Set `headers`
        if let headers {
            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }

        // Set `httpMethod`
        if let httpMethod: String = method?.rawValue {
            urlRequest.httpMethod = httpMethod
        }

        // Set `httpBody` and `Content-Type`
        if let contentType, let body {
            urlRequest.addValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
            switch contentType {
            case .json:
                guard let body = body as? JSON, !body.isEmpty else { break }
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
                } catch {
                    throw error
                }
            case .urlencoded:
                guard let body = body as? JSON, !body.isEmpty else { break }
                var bodyURLComponents: URLComponents = .init()
                bodyURLComponents.queryItems = body.map {
                    URLQueryItem(name: $0, value: String(describing: $1))
                }
                urlRequest.httpBody = bodyURLComponents.query?.data(using: .utf8)
            }
        } else {
            if let body = body as? String {
                urlRequest.httpBody = body.data(using: .utf8)
            }
        }

        return urlRequest
    }
}
