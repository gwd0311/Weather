//
//  LazyView.swift
//  Weather
//
//  Created by hanjongwoo on 10/21/24.
//

import SwiftUI

struct LazyView<Content: View>: View {
    private let build: () -> Content

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}
