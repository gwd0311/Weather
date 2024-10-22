//
//  Debug.swift
//  Weather
//
//  Created by hanjongwoo on 10/21/24.
//

import Foundation

public func debug(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    print(["::::"] + items, separator: separator, terminator: terminator)
    #endif
}
