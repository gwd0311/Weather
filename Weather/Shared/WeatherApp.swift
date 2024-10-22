//
//  WeatherApp.swift
//  Weather
//
//  Created by hanjongwoo on 10/21/24.
//

import SwiftUI
import BaseKit

typealias BaseView<Content: View> = _BaseView<Content, AppAlert, AppSheet, AppActionSheet, AppPush, AppPopup, AppFullScreen, AppError>
typealias NavBaseView<Content: View> = _NavBaseView<Content, AppAlert, AppSheet, AppActionSheet, AppPush, AppPopup, AppFullScreen, AppError>
typealias BaseViewModel = _BaseViewModel<AppAlert, AppSheet, AppActionSheet, AppPush, AppPopup, AppFullScreen, AppError>
typealias BaseRepository = _BaseRepository<AppError>

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
