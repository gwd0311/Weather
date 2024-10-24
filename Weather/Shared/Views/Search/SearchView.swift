//
//  SearchView.swift
//  Weather
//
//  Created by hanjongwoo on 10/24/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        BaseView(viewModel: viewModel) {
            VStack(spacing: 0) {
                SearchBar(searchText: $viewModel.searchText)
                    .focused($isTextFieldFocused)
                    .onChange(of: viewModel.searchText) { newValue in
                        viewModel.filterCities(with: newValue)
                    }
                CityListView(viewModel: viewModel)
            }
            .background(Color.theme.searchColor)
            .onAppear {
                viewModel.onAppear()
                isTextFieldFocused = true
            }
        }
    }
}

final class SearchViewModel: BaseViewModel {
    
    @Published private(set) var selectedCity: City = .asan
    @Published private(set) var cityLists: [City] = []
    @Published private(set) var searchList: [City] = []
    
    @Published var isLoadingPage: Bool = false
    @Published var searchText: String = ""
    
    private var currentPage = 0
    private let pageSize = 15
    private let weatherRepository: WeatherRepository

    init(weatherRepository: WeatherRepository = RepositoryManager.weatherRepository) {
        self.weatherRepository = weatherRepository
        super.init()
        configure()
    }
    
    override func configure() {
        weatherRepository.$isLoading
            .assign(to: &$isLoading)

        weatherRepository.$cityLists
            .sink { [weak self] cityLists in
                self?.cityLists = cityLists
                self?.resetSearchList()
            }
            .store(in: &subscriptions)

        weatherRepository.$selectedCity
            .assign(to: &$selectedCity)
    }
}

// MARK: - Public Functions
extension SearchViewModel {
    
    func onAppear() {
        currentPage = 0
        resetSearchList()
    }
    
    func loadMoreCitiesIfNeeded(currentItem: City? = nil) {
        guard !isLoadingPage else {
            return
        }

        if shouldLoadMore(currentItem: currentItem) {
            isLoadingPage = true
            let citiesToLoad = searchText.isEmpty ? cityLists : filterAndSortCities()
            loadMore(from: citiesToLoad)
        }
    }
    
    func filterCities(with searchText: String) {
        self.searchText = searchText
        
        if searchText.isEmpty {
            resetSearchList()
        } else {
            let filteredCities = filterAndSortCities()
            searchList = Array(filteredCities.prefix(pageSize))
            currentPage = 0
        }
    }
    
    func updateCity(_ city: City) {
        weatherRepository.updateCity(city)
    }
}

// MARK: - Private Functions
private extension SearchViewModel {
    
    private func resetSearchList() {
        searchList = Array(cityLists.prefix(pageSize))
    }
    
    private func filterAndSortCities() -> [City] {
        return cityLists
            .filter { $0.name.lowercased().contains(searchText.lowercased()) }
            .sorted {
                $0.name.lowercased().hasPrefix(searchText.lowercased()) && !$1.name.lowercased().hasPrefix(searchText.lowercased())
            }
    }
    
    private func shouldLoadMore(currentItem: City?) -> Bool {
        guard let currentItem = currentItem else {
            return false
        }
        
        guard let index = searchList.firstIndex(where: { $0.id == currentItem.id }) else {
            return false
        }
        
        let shouldLoad = index >= searchList.endIndex - 5
        return shouldLoad
    }
    
    private func loadMore(from cities: [City]) {
        let startIndex = searchList.count
        let endIndex = min(startIndex + pageSize, cities.count)

        if startIndex >= endIndex {
            isLoadingPage = false
            return
        }

        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            let newCities = Array(cities[startIndex..<endIndex])
            DispatchQueue.main.async {
                self.searchList.append(contentsOf: newCities)
                self.isLoadingPage = false
            }
        }
    }

}
