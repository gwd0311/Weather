//
//  LineDivider.swift
//  Weather
//
//  Created by hanjongwoo on 10/23/24.
//

import SwiftUI

struct LineDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.theme.lineColor)
            .frame(height: 1)
            .padding(.bottom, 8)
    }
}
