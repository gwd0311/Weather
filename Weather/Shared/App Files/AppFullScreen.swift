//
//  AppFullScreen.swift
//  iOSPhotos
//
//  Created by hanjongwoo on 8/4/24.
//

import SwiftUI
import BaseKit

enum AppFullScreen {
//    case photoDetail(photo: Photo, nameSpace: Namespace.ID)
}

extension AppFullScreen: FullScreenPresentable {
    
    var id: String {
//        switch self {
//        case .photoDetail:
//            "photoDetail"
//        }
        ""
    }
    
    @ViewBuilder
    var fullScreen: some View {
//        switch self {
//        case .photoDetail(let photo, let namespace):
//            PhotoDetailView(photo: photo, namespace: namespace)
//        }
        EmptyView()
    }
}
