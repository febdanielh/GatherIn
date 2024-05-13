//
//  LocationManager.swift
//  Sportify
//
//  Created by Febrian Daniel on 19/03/24.
//

import Foundation
import MapKit
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    func requestLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestLocation()
        self.locationManager.startUpdatingLocation()
    }
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            print(locationManager.authorizationStatus.rawValue.description)
        case .restricted:
            print(locationManager.authorizationStatus.rawValue.description)
            print("Your location is restricted")
        case .denied:
            print("Your location is denied")
            print(locationManager.authorizationStatus.rawValue.description)
        case .authorizedAlways, .authorizedWhenInUse:
            print(locationManager.authorizationStatus.rawValue.description)
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = locationManager.authorizationStatus
        if status == .denied {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle any errors that `CLLocationManager` returns.
    }
    
    func getUserDistance(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> Double {
        guard let userLocation = userLocation else {
            // Handle case where user location is not available
            return 0.0
        }
        
        let destinationLocation = CLLocation(latitude: latitude, longitude: longitude)
        let distance = userLocation.distance(from: destinationLocation) / 1000
        return distance
    }
    
    func searchCity(input: String, completion: @escaping ([MKMapItem]?, Error?) -> Void) {
        requestPlaces(input: input, resultType: .address, completion: completion)
    }
    
    func searchPOI(input: String, completion: @escaping ([MKMapItem]?, Error?) -> Void) {
        requestPlaces(input: input, completion: completion)
    }
    
    func requestPlaces(input: String, resultType: MKLocalSearch.ResultType = .pointOfInterest, completion: @escaping ([MKMapItem]?, Error?) -> Void) {
        var requestedPlaces: [MKMapItem] = []
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = input
        request.resultTypes = resultType
        request.pointOfInterestFilter = .includingAll
        
        let center = userLocation
        request.region = MKCoordinateRegion(center: center?.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error)  in
            if let response = response {
                let mapItems = response.mapItems
                let sortedMapItems = mapItems.sorted {
                    let location1 = $0.placemark.location
                    let location2 = $1.placemark.location
                    let distance1 = center?.distance(from: location1!)
                    let distance2 = center?.distance(from: location2!)
                    return distance1 ?? 0 < distance2 ?? 0
                }
                
                let nearestMapItems = Array(sortedMapItems)
                print(nearestMapItems)
                requestedPlaces.append(contentsOf: nearestMapItems)
                completion(requestedPlaces, nil)
                
            } else {
                completion(nil, error)
            }
        }
    }
    
    func searchLocationCoordinate(input: String, completion: @escaping (MKMapItem?, Error?) -> Void) {
        var requestedPlaces: MKMapItem = MKMapItem()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = input
        request.pointOfInterestFilter = .includingAll
        
        let center = self.userLocation
        request.region = MKCoordinateRegion(center: center?.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error)  in
            if let response = response {
                let mapItems = response.mapItems
                let sortedMapItems = mapItems.sorted {
                    let location1 = $0.placemark.location
                    let location2 = $1.placemark.location
                    let distance1 = center?.distance(from: location1!)
                    let distance2 = center?.distance(from: location2!)
                    return distance1 ?? 0 < distance2 ?? 0
                }
                
                let nearestMapItems = Array(sortedMapItems)
                print(nearestMapItems)
                requestedPlaces = nearestMapItems.first ?? MKMapItem()
                completion(requestedPlaces, nil)
                
            } else {
                completion(nil, error)
            }
        }
    }
    
    func requestVenuesforHome(input: String, completion: @escaping ([MKMapItem]?, Error?) -> Void) {
        var requestedPlaces: [MKMapItem] = []
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = input
        request.resultTypes = .pointOfInterest
        
        let center = self.userLocation
        request.region = MKCoordinateRegion(center: center?.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error)  in
            guard let response = response else {
                completion(nil, error)
                return
            }
            
            let mapItems = response.mapItems
            let sortedMapItems = mapItems.sorted {
                let location1 = $0.placemark.location
                let location2 = $1.placemark.location
                let distance1 = center?.distance(from: location1!)
                let distance2 = center?.distance(from: location2!)
                return distance1 ?? 0 < distance2 ?? 0
            }
            
            let nearestMapItems = Array(sortedMapItems.prefix(2))
            print(nearestMapItems)
            
            requestedPlaces = nearestMapItems
            completion(requestedPlaces, nil)
        }
    }
}
