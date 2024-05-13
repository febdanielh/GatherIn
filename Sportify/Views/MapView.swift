//
//  MapView.swift
//  Sportify
//
//  Created by Febrian Daniel on 26/04/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    var titleLokasi: String
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
        
        let lokasiAnnotation = MKPointAnnotation()
        lokasiAnnotation.coordinate = coordinate
        lokasiAnnotation.title = titleLokasi
        uiView.addAnnotation(lokasiAnnotation)
    }
}

#Preview {
    MapView(coordinate: CLLocationCoordinate2D(latitude: -6.2, longitude: 106), titleLokasi: "Coba")
}
