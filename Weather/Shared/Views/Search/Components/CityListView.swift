//
//  CityListView.swift
//  Weather
//
//  Created by hanjongwoo on 10/25/24.
//

import SwiftUI

struct CityListView: View {
    
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.searchList, id: \.self) { city in
                    VStack(alignment: .leading, spacing: 0) {
                        Group {
                            Text(city.name)
                                .font(.headline)
                                .padding(.bottom, 2)
                            Text(city.country)
                                .font(.subheadline)
                        }
                        .foregroundStyle(.white)
                        .padding(.bottom, 12)
                        LineDivider()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            viewModel.updateCity(city)
                            viewModel.dismiss()
                        }
                    }
                }
                
                if viewModel.isLoadingPage {
                    ProgressView()
                } else if viewModel.searchList.isEmpty {
                    Text("No cities found")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    Color.clear
                        .frame(height: 1)
                        .onAppear {
                            viewModel.loadMoreCitiesIfNeeded(currentItem: viewModel.searchList.last)
                        }
                }
            }
            .padding()
        }
    }
}
