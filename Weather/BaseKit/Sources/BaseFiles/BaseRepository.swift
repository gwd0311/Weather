//
//  BaseRepository.swift
//  iOSPhotos
//
//  Created by hanjongwoo on 8/3/24.
//

import SwiftUI
import Combine

// MARK: _BaseRepository

/**
 All the repositories show inherit BaseRepository.
 ```
 // It is recommended to use typealias to define BaseView for your app.
 // The custom error should be declared beforehand.
 typealias BaseRepository = _BaseRepository<AppError>
 
 // Declare Repository
 
 final class SomeRepository: BaseRepository {
    ...
 }
 
 ```
 */

open class _BaseRepository<T: Throwable>: ObservableObject {
    @Published public private(set) var isLoading: Bool = false
    @Published public private(set) var callSuccess: Bool = false
    @Published public private(set) var error: T?
    public var subscriptions: [AnyCancellable] = []
    
    public init() {}
    
    public func setIsLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    public func setError(_ error: T) {
        print("🛑 [ERROR]: \(error.localizedDescription)")
        self.error = error
    }
    
    public func setCallSuccess(_ bool: Bool) {
        self.callSuccess = bool
    }
    
    open func clear() {
        self.isLoading = false
        self.callSuccess = false
        self.error = nil
        self.subscriptions.removeAll()
    }
}
