//
//  AppActionSheet.swift
//  iOSPhotos
//
//  Created by hanjongwoo on 8/4/24.
//

import SwiftUI
import BaseKit

enum AppActionSheet {
   case someActionSheet
}

extension AppActionSheet: ActionSheetPresentable {
    
    var id: String {
        switch self {
        case .someActionSheet:
            "someActionSheet"
        }
    }
    
    var title: LocalizedStringKey? {
        switch self {
        case .someActionSheet:
            ""
        }
    }
    
    var actions: some View {
        switch self {
        case .someActionSheet:
            EmptyView()
        }
    }
}
