//
//  File.swift
//  BaseKit
//
//  Created by hanjongwoo on 10/23/24.
//

import Foundation

extension Double {
    
    public var kelvinToCelsius: Int {
        Int(self - 273.15)
    }
    
    public var formattedWithCommas: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0

        return numberFormatter.string(from: NSNumber(value: self)) ?? "-"
    }
    
}
