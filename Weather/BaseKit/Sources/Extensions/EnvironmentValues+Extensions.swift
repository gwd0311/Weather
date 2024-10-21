//
//  EnvironmentValues+Extensions.swift
//  iOSPhotos
//
//  Created by hanjongwoo on 8/3/24.
//

import SwiftUI

// MARK: - RootPresentationMode

typealias RootPresentationMode = Bool

extension RootPresentationMode {
    mutating func dismiss() {
        toggle()
    }
}

// MARK: - RootPresentationModeKey

struct RootPresentationModeKey: EnvironmentKey {
    public static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

extension EnvironmentValues {
    var rootPresentationMode: Binding<RootPresentationMode> {
        get {
            return self[RootPresentationModeKey.self]
        }
        set {
            self[RootPresentationModeKey.self] = newValue
        }
    }
}
