//
//  AppPush.swift
//  iOSPhotos
//
//  Created by hanjongwoo on 8/3/24.
//


import SwiftUI
import BaseKit

enum AppPush {
//    case photoDetail(photo: Photo, nameSpace: Namespace.ID)
}

extension AppPush: NavigationPushable  {
    var id: String {
        switch self {
//        case .photoDetail:
//            "photoDetail"
        }
    }
    
    @ViewBuilder var destination: some View {
//        switch self {
//        case .photoDetail(let photo, let namespace):
//            LazyView(PhotoDetailView(photo: photo, namespace: namespace))
//        }
        EmptyView()
    }
}

extension AppPush: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
