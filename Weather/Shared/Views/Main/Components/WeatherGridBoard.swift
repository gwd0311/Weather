//
//  WeatherBoard.swift
//  Weather
//
//  Created by hanjongwoo on 10/23/24.
//

import SwiftUI

struct WeatherGridBoard: View {
    let title: String
    let content: String
    let footer: String?

    init(title: String, content: String, footer: String? = nil) {
        self.title = title
        self.content = content
        self.footer = footer
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.white)
                .opacity(0.8)
            Spacer()
            Text(content)
                .foregroundStyle(.white)
                .fontSized(30)
            Spacer()
            if footer == nil || footer == "-" {
                Text(" ")
                    .foregroundStyle(.white)
                    .opacity(0.8)
            } else {
                Text(footer ?? " ")
                    .foregroundStyle(.white)
                    .opacity(0.8)
            }
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(1.0, contentMode: .fit)
        .padding()
        .background(Color.theme.boardColor)
        .cornerRadius(10)
    }
}

#Preview {
    WeatherGridBoard(
        title: "바람 속도",
        content: "1.97m/s",
        footer: "강풍: 3.39m/s"
    )
}
