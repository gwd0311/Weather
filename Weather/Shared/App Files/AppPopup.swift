//
//  AppPopup.swift
//  iOSPhotos
//
//  Created by hanjongwoo on 8/4/24.
//

import SwiftUI
import BaseKit

enum AppPopup: Identifiable {
//    case notice(onClose: () -> Void)
}

extension AppPopup: Popupable {
    var id: String {
//        switch self {
//        case .notice:
//        }
        ""
    }
    
    var popup: some View {
        EmptyView()
    }
    
    @ViewBuilder
    var sheet: some View {
//        switch self {
//        case .notice(let onClose):
//            NoticeBottomSheet(onClose: onClose)
//        }
        EmptyView()
    }
}
