//
//  SearchBar.swift
//  Weather
//
//  Created by hanjongwoo on 10/24/24.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                    .padding(.trailing, 20)
                TextField("Search", text: $searchText)
            }
            .padding()
            .background(.white.opacity(0.5))
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding()
        }
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}
