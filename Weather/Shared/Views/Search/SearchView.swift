//
//  SearchView.swift
//  Weather
//
//  Created by hanjongwoo on 10/24/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel: SearchViewModel = SearchViewModel()
    
    let cities = [
        City(id: 1, name: "Seoul", country: "KR", coord: Coord(lon: 127.97, lat: 36.56)),
        City(id: 2, name: "Tokyo", country: "JP", coord: Coord(lon: 139.76, lat: 35.68)),
        City(id: 3, name: "New York", country: "US", coord: Coord(lon: -74.01, lat: 40.71)),
        City(id: 4, name: "London", country: "GB", coord: Coord(lon: -0.12, lat: 51.51)),
        City(id: 5, name: "Paris", country: "FR", coord: Coord(lon: 2.35, lat: 48.85)),
        City(id: 6, name: "Moscow", country: "RU", coord: Coord(lon: 37.61, lat: 55.75)),
        City(id: 7, name: "Berlin", country: "DE", coord: Coord(lon: 13.40, lat: 52.52))
    ]
    
    var body: some View {
        BaseView(viewModel: viewModel) {
            VStack(spacing: 0) {
                SearchBar(searchText: .constant(""))
                
                ScrollView {
                    LazyVStack {
                        ForEach(cities, id: \.self) { city in
                            Text(city.name)
                                .foregroundStyle(.black)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.dismiss()
                                    }
                                }
                        }
                    }
                }
            }
            .background(Color.theme.backgroundColor)
        }
    }
}

final class SearchViewModel: BaseViewModel {
}
