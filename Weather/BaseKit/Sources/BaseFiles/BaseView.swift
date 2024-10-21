//
//  BaseView.swift
//  iOSPhotos
//
//  Created by hanjongwoo on 8/3/24.
//

import SwiftUI
import Foundation

// MARK: _BaseView

/**
 All the views show be wrapped with BaseView to use methods defined in BaseViewModel
 ```
 // It is recommended to use typealias to define BaseView for your app.
 // The custom error, alert, sheet, action sheet, navigation destination, popup, and full screen should be declared beforehand.
 typealias BaseView<Content: View> = _BaseView<Content, AppAlert, AppSheet, AppActionSheet, AppPush, AppPopup, AppFullScreen, AppError>
 ```
 */
public struct _BaseView<Content: View,
                        Alert: Alertable,
                        Sheet: SheetPresentable,
                        ActionSheet: ActionSheetPresentable,
                        Push: NavigationPushable,
                        Popup: Popupable,
                        FullScreen: FullScreenPresentable,
                        Error: Throwable>: View {

    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @StateObject private var viewModel: _BaseViewModel<Alert, Sheet, ActionSheet, Push, Popup, FullScreen, Error>

    private let content: Content
    private let backgroundColor: Color?
    private let isRoot: Bool

    public init(viewModel: @autoclosure @escaping () -> _BaseViewModel<Alert, Sheet, ActionSheet, Push, Popup, FullScreen, Error>,
        backgroundColor: Color? = .black,
         isRoot: Bool = false,
         @ViewBuilder content: () -> Content) {
        _viewModel = StateObject(wrappedValue: viewModel())
        self.backgroundColor = backgroundColor
        self.content = content()
        self.isRoot = isRoot

        // UINavigationBar.appearance().largeTitleTextAttributes = [.font: Font....]
        // UINavigationBar.appearance().titleTextAttributes = [.font: Font....]
    }

    public var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                baseContent
            }
        } else {
            NavigationView {
                baseContent
            }
        }
    }
    
    @ViewBuilder
    private var baseContent: some View {
        ZStack {
            content
            popup
        }
        .background(contentBackgroundColor.ignoresSafeArea())
        .onAppear {
            viewModel.onAppear(
                rootPresentationMode: rootPresentationMode,
                presentationMode: presentationMode
            )
        }
        .onDisappear { viewModel.onDisAppear() }
        .alert(item: $viewModel.alert) { $0.alert }
        .sheet(item: $viewModel.sheet) { $0.sheet }
        .fullScreenCover(item: $viewModel.fullScreen) { $0.fullScreen }
        .actionSheet(item: $viewModel.actionSheet)
        .push(item: $viewModel.push, isRootActive: isRoot ? rootPresentationMode.projectedValue : .constant(false))
    }

    private var contentBackgroundColor: Color {
        return backgroundColor ?? .black
    }
    
    @ViewBuilder
    private var popup: some View {
        if let appPopup = viewModel.popup {
            appPopup.popup
        } else {
            EmptyView()
        }
    }
}

// MARK: NavBaseView

/**
 All the views who acts as an root view of a navigation stack show be wrapped with NavBaseView to use methods defined in BaseViewModel
 ```
 // It is recommended to use typealias to define NavBaseView for your app.
 // The custom error, alert, sheet, action sheet, navigation destination, popup, and full screen should be declared beforehand.
 typealias NavBaseView<Content: View> = _NavBaseView<Content, AppAlert, AppSheet, AppActionSheet, AppPush, AppPopup, AppFullScreen, AppError>
 ```
 */

public struct _NavBaseView<Content: View,
                           Alert: Alertable,
                           Sheet: SheetPresentable,
                           ActionSheet: ActionSheetPresentable,
                           Push: NavigationPushable,
                           Popup: Popupable,
                           FullScreen: FullScreenPresentable,
                           Error: Throwable>: View
{
    @State private var isRootActive: Bool = false

    private let viewModel: _BaseViewModel<Alert, Sheet, ActionSheet, Push, Popup, FullScreen, Error>
    private let content: Content
    private let backgroundColor: Color?

    public init(viewModel: _BaseViewModel<Alert, Sheet, ActionSheet, Push, Popup, FullScreen, Error>, backgroundColor: Color? = .black, @ViewBuilder content: () -> Content) {
        self.viewModel = viewModel
        self.content = content()
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        navigationView
            .environment(\.rootPresentationMode, $isRootActive)
    }

    @ViewBuilder private var navigationView: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                _BaseView(viewModel: viewModel, backgroundColor: backgroundColor, isRoot: true) {
                    content
                }
            }
        } else {
            NavigationView {
                _BaseView(viewModel: viewModel, backgroundColor: backgroundColor, isRoot: true) {
                    content
                }
            }
            .navigationViewStyle(.stack)
        }
    }
}

// MARK: AppNavigator

public extension View {
    func push<Push: NavigationPushable>(item: Binding<Push?>, isRootActive: Binding<Bool>) -> some View {
        modifier(AppNavigator(push: item, isRootActive: isRootActive))
    }
}

struct AppNavigator<Push: NavigationPushable>: ViewModifier {
    @Binding var push: Push?
    @Binding var isRootActive: Bool

    @State private var isActive: Bool = false

    func body(content: Content) -> some View {
        content
            .onChange(of: isRootActive) { newValue in
                guard !newValue else { return }
                isActive = false
            }
            .onChange(of: push) { newValue in
                guard newValue != nil else { return }
                isActive = true
                isRootActive = true
            }
            .onChange(of: isActive) { newValue in
                guard !newValue else { return }
                push = nil
            }
            .link(destination: destination, isActive: $isActive)
    }

    @ViewBuilder private var destination: some View {
        if let push {
            push.destination
        } else {
            EmptyView()
        }
    }
}

fileprivate extension View {
    @ViewBuilder
    func link<Content: View>(destination: Content, isActive: Binding<Bool>) -> some View {
        if #available(iOS 16.0, *) {
            navigationDestination(isPresented: isActive) {
                destination
            }
        } else {
            background(
                NavigationLink(destination: destination, isActive: isActive) {}
            )
        }
    }
}
