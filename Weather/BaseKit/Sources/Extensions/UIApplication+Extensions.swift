//
//  UIApplication+Extensions.swift
//  iOSPhotos
//
//  Created by hanjongwoo on 8/4/24.
//

import SwiftUI
 
extension UIApplication {
    public func setDefaultKeyboard() {
        guard let window = windows.first else { return }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window.addGestureRecognizer(tapRecognizer)
    }
    
    public func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    public func goToAccessSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            Self.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
 }
 
extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

