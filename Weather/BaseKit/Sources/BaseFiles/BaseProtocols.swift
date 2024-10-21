//
//  BaseProtocols.swift
//  iOSPhotos
//
//  Created by hanjongwoo on 8/3/24.
//

import Foundation
import SwiftUI

// MARK: Throwable
/**
 This protocol is used to define custom errors. You can handle error with handleError in BaseViewModel.
 ```
 // Define Error
 enum AppError: Throwable {
    ...
 }
 
 // Handle Error
 override func handleError(_ error: AppError) {
    switch error {
        ...
    }
 }
 ```
 */
public protocol Throwable: Error {
    var errorDescription: String? { get }
    static var defaultError: Self { get }
    static func from(_ error: Error) -> Self
}

// MARK: Alertable
/**
 This protocol is used to define custom alerts. You can present alert with presentAlert in BaseViewModel.
 ```
 // Define Alert
 enum AppAlert: Alertable {
    case someAlert
 }
 
 // Present Alert
 presentAlert(.someAlert)
 ```
 */
public protocol Alertable: Identifiable {
    var id: String { get }
    var alert: Alert { get }
}

// MARK: SheetPresentable
/**
 This protocol is used to define custom modal (bottom sheet). You can present modal with presentSheet in BaseViewModel.
 ```
 // Define Sheet
 enum AppSheet: SheetPresentable {
    case someSheet
 }
 
 // Present Sheet
 presentSheet(.someSheet)
 ```
 */
public protocol SheetPresentable: Identifiable {
    associatedtype Sheet: View
    
    var id: String { get }
    var sheet: Sheet { get }
}

// MARK: ActionSheetPresentable
/**
 This protocol is used to define custom action sheet. You can present modal with presentActionSheet in BaseViewModel.
 ```
 // Define Action Sheet
 enum AppActionSheet: ActionSheetPresentable {
    case someActionSheet
 }
 
 // Present Action Sheet
 presentActionSheet(.someActionSheet)
 ```
 - warning: This is available in iOS version only 15 or above. If unavailable, leave implementation of this protocol empty and use Popupable or else instead to make action sheet.
 */
public protocol ActionSheetPresentable: Identifiable, Equatable {
    associatedtype ActionSheet: View
    var id: String { get }
    var title: LocalizedStringKey? { get }
    var actions: ActionSheet { get }
}

struct AppActionSheetModifier<ActionSheet: ActionSheetPresentable>: ViewModifier {
    @Binding var appActionSheet: ActionSheet?
    @State private var show: Bool = false

    func body(content: Content) -> some View {
            if #available(iOS 15.0, *) {
                content
                    .onChange(of: appActionSheet) { newValue in
                        show = newValue != nil
                    }
                    .onChange(of: show) { newValue in
                        guard !newValue else { return }
                        appActionSheet = nil
                    }
                    // TODO: - Fix on iPad
                    .confirmationDialog(appActionSheet?.title ?? "", isPresented: $show) { appActionSheet?.actions }
            } else {
                content
            }
    }
}

extension View {
    func actionSheet<ActionSheet: ActionSheetPresentable>(item: Binding<ActionSheet?>) -> some View {
        modifier(AppActionSheetModifier(appActionSheet: item))
    }
}

// MARK: NavigationPushable
/**
 This protocol is used to define custom navigation. You can push another view in current navigation stack. **Make sure the root view to be NavBaseView, unless push will not work.**
 ```
 // Define Navigation Destinations
 enum AppPush: NavigationPushable {
    case somePush
 }
 
 // Push into Navigation Stack
 push(.somePush)
 ```
 */
public protocol NavigationPushable: Identifiable, Equatable {
    associatedtype Destination: View
    
    var id: String { get }
    var destination: Destination { get }
}

// MARK: Popupable
/**
 This protocol is used to define custom popup. You can show another view over the current BaseView with ZStack.
 ```
 // Define Popup
 enum AppPopup: Popupable {
    case somePopup
 }
 
 // Show Popup
 presentPopup(.somePopup)
 ```
 */

public protocol Popupable: Identifiable {
    associatedtype Popup: View
    
    var id: String { get }
    var popup: Popup { get }
}

// MARK: FullScreenPresentable
/**
 This protocol is used to define custom fullScreen. You can present fullScreenCover in current base view.
 ```
 // Define FullScreen
 enum AppFullScreen: FullScreenPresentable {
    case someFullScreen
 }
 
 // Show FullScreen
 presentFullScreen(.someFullScreen)
 ```
 */
public protocol FullScreenPresentable: Identifiable {
    associatedtype FullScreen: View
    
    var id: String { get }
    var fullScreen: FullScreen { get }
}

