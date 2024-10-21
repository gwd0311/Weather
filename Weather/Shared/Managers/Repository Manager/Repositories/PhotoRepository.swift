//
//  PhotoRepository.swift
//  Weather
//
//  Created by hanjongwoo on 10/21/24.
//

//import PhotosKit
import BaseKit
import SwiftUI

final class PhotoRepository: BaseRepository {
    
    @Published private(set) var photos: [Photo] = []
    @Published private(set) var selectedPhoto: Photo = .empty
    @Published private(set) var currentPage: Int = 0
    
//    private let photoService: PhotoServiceProtocol
//    
//    init(
//        photoService: PhotoServiceProtocol = ServiceManager.shared.photoService
//    ) {
//        self.photoService = photoService
//    }
    
    override func clear() {
        photos = []
    }
}

// MARK: - Public Functions
extension PhotoRepository {
//    func requestPhotoLibraryAccess() async -> Result<Void, AppError> {
//        await photoService.requestPhotoLibraryAccess()
//    }
    
//    func setSelectedPhoto(_ photo: Photo) {
//        self.selectedPhoto = photo
//    }
//    
//    func fetchPhotos() {
//        currentPage += 1
//        Task { @MainActor in
//            let idSet = Set(photos.map { $0.id })
//            let result = await photoService.fetchPhotos(page: currentPage, excludedAssetIDs: idSet)
//            switch result {
//            case .success(let photos):
//                self.photos.append(contentsOf: photos)
//                setCallSuccess(true)
//            case .failure(let err):
//                debug(err.localizedDescription)
//                setCallSuccess(false)
//            }
//        }
//    }
}
