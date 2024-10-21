//
//  RepositoryManager.swift
//  Weather
//
//  Created by hanjongwoo on 10/21/24.
//

import Foundation

enum RepositoryManager {
    static let photoRepository: PhotoRepository = PhotoRepository()
}

extension RepositoryManager {
    static func clear() {
        photoRepository.clear()
    }
}
