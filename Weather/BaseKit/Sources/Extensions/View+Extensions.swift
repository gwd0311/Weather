//
//  File.swift
//  
//
//  Created by hanjongwoo on 8/8/24.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func hide(_ bool: Bool) -> some View {
        if bool {
            EmptyView()
        } else {
            self
        }
    }
    
    func fontSized(_ size: CGFloat) -> some View {
        self.font(.system(size: size))
    }
}
