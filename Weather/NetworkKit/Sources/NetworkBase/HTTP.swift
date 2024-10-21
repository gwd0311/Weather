//
//  File.swift
//  NetworkKit
//
//  Created by hanjongwoo on 10/21/24.
//

import Foundation

public typealias JSON = [String: Any]

// MARK: - HTTPQuery

public typealias HTTPQuery = JSON

// MARK: - HTTPHeaders

public typealias HTTPHeaders = [String: String]

// MARK: - HTTPMethod

public enum HTTPMethod: String {
    case post
    case get
    case put
    case patch
    case delete
}

// MARK: - HTTPBody

public protocol HTTPBody {}
extension String: HTTPBody {}
extension JSON: HTTPBody {}

// MARK: - HTTPContentType

public enum HTTPContentType: String {
    case json = "application/json"
    case urlencoded = "application/x-www-form-urlencoded"
}
