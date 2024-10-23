//
//  WeatherMapBoard.swift
//  Weather
//
//  Created by hanjongwoo on 10/23/24.
//

import SwiftUI
import MapKit

struct WeatherMapBoard: View {
    
    let lat: Double
    let lon: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("강수량")
                .foregroundStyle(.white)
                .fontSized(10)
                .padding(.bottom, 8)
            WeatherMapView(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            .frame(height: 300)
        }
        .padding()
        .background(Color.theme.boardColor)
        .cornerRadius(10)
        .padding()
    }
}