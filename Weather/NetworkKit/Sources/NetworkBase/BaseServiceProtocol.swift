//
//  File.swift
//  
//
//  Created by Jong Won Moon on 4/18/24.
//

import Foundation

public protocol BaseServiceProtocol: AnyObject {
    var headers: [String: String] { get }
}

public extension BaseServiceProtocol {
    var defaultHeaders: [String: String] {
        [:]
    }
}
