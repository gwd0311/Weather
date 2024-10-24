//
//  AppFullScreen.swift
//  iOSPhotos
//
//  Created by hanjongwoo on 8/4/24.
//

import SwiftUI
import BaseKit

enum AppFullScreen {
    case search
}

extension AppFullScreen: FullScreenPresentable {
    
    var id: String {
        switch self {
        case .search:
            "search"
        }
    }
    
    @ViewBuilder
    var fullScreen: some View {
        switch self {
        case .search:
            SearchView()
        }
        EmptyView()
    }
}
