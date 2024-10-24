//
//  File.swift
//  
//
//  Created by Jong Won Moon on 4/18/24.
//

import Foundation

public struct BaseResponse<T: Decodable>: Decodable {
    public let status: Bool
    public let data: T?
    public let error: GenericError?
}

public struct OnlyStatusResponse: Decodable {
    public let status: Bool
    public let error: GenericError?
}
