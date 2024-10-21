//
//  AppSheet.swift
//  iOSPhotos
//
//  Created by hanjongwoo on 8/4/24.
//

import SwiftUI
import BaseKit

enum AppSheet {
    case photoDetail(photo: Photo, namespace: Namespace.ID)
}

extension AppSheet: SheetPresentable {
    var id: String {
        switch self {
        case .photoDetail:
            return "practicePreview"
        }
    }
    
    var sheet: some View {
        EmptyView()
//        switch self {
//        case .photoDetail(let photo, let namespace):
//            return LazyView(PhotoDetailView(photo: photo, namespace: namespace))
//        }
    }
}
