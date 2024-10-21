//
//  File.swift
//  
//
//  Created by hanjongwoo on 8/8/24.
//

import Foundation

public enum GalleryGridColumns: Int, CaseIterable {
    case one = 1
    case three = 3
    case five = 5
    
    public var next: Self {
        let all = Self.allCases
        let index = all.firstIndex(of: self) ?? 0
        return all[index + 1 < all.count ? index + 1 : index]
    }

    public var previous: Self {
        let all = Self.allCases
        let index = all.firstIndex(of: self) ?? 0
        return all[index > 0 ? index - 1 : index]
    }
}
