//
//  AppAlert.swift
//  iOSPhotos
//
//  Created by hanjongwoo on 8/3/24.
//


import SwiftUI
import BaseKit

enum AppAlert: Identifiable {
    case unexpectedError
    case photoLibraryFetchError
}

extension AppAlert: Alertable {

    var id: String {
        switch self {
        case .unexpectedError:
            return "unexpectedError"
        case .photoLibraryFetchError:
            return "photoLibraryFetchError"
        }
    }
    
    var alert: Alert {
        switch self {
        case .unexpectedError:
            return Alert(
                title: Text("오류"),
                message: Text("이용에 불편을 드려 죄송합니다.\n예기치 않은 오류가 발생했습니다.\n다시 시도해주시기 바랍니다."),
                dismissButton: .default(Text("확인"))
            )
        case .photoLibraryFetchError:
            return Alert(
                title: Text("오류"),
                message: Text("사진 라이브러리를 가져오는데 실패하였습니다.\n[설정>iOSPhotos>사진]에서 접근을 허용해주시기 바랍니다."),
                dismissButton: .default(Text("확인"))
            )
        }
    }
}
