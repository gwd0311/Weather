//
//  File.swift
//  
//
//  Created by Jong Won Moon on 4/18/24.
//

import Foundation

func appID(isLite: Bool) -> String {
    isLite ? "esat-j-lite" : "esat-j"
}

public protocol BaseServiceProtocol: AnyObject {
    var isDev: Bool { get }
    var isLite: Bool { get }
    var headers: [String: String] { get }
}

public extension BaseServiceProtocol {
    var defaultHeaders: [String: String] {
        ["x-esat-application-id": appID(isLite: isLite)]
    }
}
