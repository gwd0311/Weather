//
//  MapView.swift
//  Weather
//
//  Created by hanjongwoo on 10/23/24.
//

import SwiftUI
import MapKit

struct WeatherMapView: UIViewRepresentable {
    
    let coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000000, longitudinalMeters: 2000000)
        mapView.setRegion(region, animated: true)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        let parent: WeatherMapView
        
        init(_ parent: WeatherMapView) {
            self.parent = parent
        }
    }
}

