//
//  Date+Extensions.swift
//
//
//  Created by hanjongwoo on 8/9/24.
//

import Foundation

public extension Date {
    public var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        return dateFormatter.string(from: self)
    }
    
    public var formattedTime: String {
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "ko_KR")
        timeFormatter.dateFormat = "a h:mm"
        return timeFormatter.string(from: self)
    }
}
