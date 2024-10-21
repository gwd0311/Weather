//
//  BaseViewModel.swift
//  iOSPhotos
//
//  Created by hanjongwoo on 8/3/24.
//

import SwiftUI
import Combine

// MARK: _BaseViewModel

/**
 All the BaseView and NavBaseViews are initialized with BaseViewModel. All the viewModels must inherit BaseViewModel
 ```
 // It is recommended to use typealias to define BaseViewModel for your app.
 // The custom error, alert, sheet, action sheet, navigation destination, popup, and full screen should be declared beforehand.
 typealias BaseViewModel = _BaseViewModel<AppAlert, AppSheet, AppActionSheet, AppPush, AppPopup, AppFullScreen, AppError>
 
 // Declare ViewModel
 
 final class SomeViewModel: BaseViewModel {
    ...
 }
 
 // Initialze BaseView with BaseViewModel
 struct SomeView: View {
     @StateObject private var viewModel = SomeViewModel()
            
    var body: some View {
        BaseView(viewModel: viewModel) {
           ...
        }
    }
 }
 ```
 */
open class _BaseViewModel<Alert: Alertable,
                          Sheet: SheetPresentable,
                          ActionSheet: ActionSheetPresentable,
                          Push: NavigationPushable,
                          Popup: Popupable,
                          FullScreen: FullScreenPresentable,
                          Error: Throwable>: ObservableObject
{
    @Published public var alert: Alert?
    @Published public var sheet: Sheet?
    @Published public var actionSheet: ActionSheet?
    @Published public var push: Push?
    @Published var fullScreen: FullScreen?
    @Published var popup: Popup?
    
    @Published public var isLoading: Bool = false
    @Published public private(set) var didAppear: Bool = false
    @Published public var didLoad: Bool = false
    
    public var subscriptions: [AnyCancellable] = []
    
    private var rootPresentationMode: Binding<RootPresentationMode>?
    private var presentationMode: Binding<PresentationMode>?
    
    public init() {}

    open func configure() {}
    
    open func handleError(_ error: Error) {}
}

// MARK: - Public Functions

extension _BaseViewModel {
    final func onAppear(rootPresentationMode: Binding<RootPresentationMode>, presentationMode: Binding<PresentationMode>) {
        self.rootPresentationMode = rootPresentationMode
        self.presentationMode = presentationMode
        
        didAppear = true
        
        guard !didLoad else { return }
        didLoad = true
        configure()
    }
    
    public final func onDisAppear() {
        didAppear = false
    }

    public final func presentAlert(_ alert: Alert) {
        self.alert = alert
    }

    public final func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    public final func presentActionSheet(_ actionSheet: ActionSheet) {
        self.actionSheet = actionSheet
    }
    
    public final func presentFullScreen(_ fullScreen: FullScreen) {
        self.fullScreen = fullScreen
    }
    
    public final func presentPopup(_ popup: Popup) {
        self.popup = popup
    }
    
    public final func dismissPopup() {
        self.popup = nil
    }

    public final func push(_ push: Push) {
        self.push = push
    }

    public final func popToRoot() {
        rootPresentationMode?.wrappedValue.dismiss()
    }

    public final func pop() {
        dismiss()
    }

    public final func dismiss() {
        presentationMode?.wrappedValue.dismiss()
    }
}
