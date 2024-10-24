//
//  File.swift
//  BaseKit
//
//  Created by hanjongwoo on 10/22/24.
//

import Foundation
import SwiftUI

public extension Color {
    static let theme = ColorTheme()
}

public struct ColorTheme : Sendable {
    public let backgroundColor = Color("backgroundColor")
    public let boardColor = Color("boardColor")
    public let lineColor = Color("lineColor")
    public let searchColor = Color("searchColor")
}
