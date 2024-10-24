//
//  MapView.swift
//  Weather
//
//  Created by hanjongwoo on 10/23/24.
//

import SwiftUI
import MapKit

import SwiftUI
import MapKit

struct WeatherMapView: UIViewRepresentable {
    
    @StateObject var viewModel: MainViewModel
    var annotation: MKPointAnnotation = MKPointAnnotation()

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        configureMap(mapView)
        setupInitialAnnotation(mapView)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        moveToCoordinate(uiView, coordinate: CLLocationCoordinate2D(latitude: viewModel.lat, longitude: viewModel.lon))
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: WeatherMapView
        
        init(_ parent: WeatherMapView) {
            self.parent = parent
        }
    }
}

// MARK: - Private Functions
private extension WeatherMapView {
    
    func configureMap(_ mapView: MKMapView) {
        let initialRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 2000000, longitudinalMeters: 2000000)
        mapView.setRegion(initialRegion, animated: true)
    }
    
    func setupInitialAnnotation(_ mapView: MKMapView) {
        annotation.coordinate = CLLocationCoordinate2D(latitude: viewModel.lat, longitude: viewModel.lon)
        mapView.addAnnotation(annotation)
    }
    
    func moveToCoordinate(_ mapView: MKMapView, coordinate: CLLocationCoordinate2D) {
        if let existingAnnotation = mapView.annotations.first(where: { $0 is MKPointAnnotation }) as? MKPointAnnotation {
            existingAnnotation.coordinate = coordinate
        } else {
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }

        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000000, longitudinalMeters: 2000000)
        mapView.setRegion(region, animated: true)
    }
    
}



