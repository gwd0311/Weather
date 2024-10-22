//
//  AppView.swift
//  iOSPhotos
//
//  Created by hanjongwoo on 8/4/24.
//

import SwiftUI
import Photos

struct AppView: View {
    @StateObject private var viewModel = AppViewModel()

    var body: some View {
        BaseView(viewModel: viewModel) {
            MainView()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification), perform: { _ in
//            viewModel.requestPhotosAccess()
        })
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

final class AppViewModel: BaseViewModel {
    @Published private(set) var isLaunching: Bool = true

    private let photoRepository: WeatherRepository
        
    init(
        photoRepository: WeatherRepository = RepositoryManager.weatherRepository
    ) {
        self.photoRepository = photoRepository
        super.init()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.launched()
        }
    }
    
    private func launched() {
        withAnimation {
            self.isLaunching.toggle()
        }
    }
    
    override func configure() {
//        userRepository.$appStatus
//            .assign(to: &$appStatus)
//        
//        userRepository.error
//            .compactMap { $0 }
//            .sink { [weak self] error in
//                guard let self else { return }
//                self.handleError(error)
//            }
//            .store(in: &subscriptions)
//        
//        $didAppear
//            .sink { [weak self] in
//                guard let self else { return }
//                self.handleDidAppear($0)
//            }
//            .store(in: &subscriptions)
//        
//        // isLoading
//        userRepository.$isLoading
//            .assign(to: &$isLoading)
    }
    
//    func requestPhotosAccess() {
//        Task { @MainActor in
//            let result = await photoRepository.requestPhotoLibraryAccess()
//            
//            switch result {
//            case .success:
//                debug("라이브러리 접근 성공")
//                photoRepository.fetchPhotos()
//            case .failure(let err):
//                presentAlert(.photoLibraryFetchError)
//                debug(err.localizedDescription)
//            }
//        }
//    }
}
