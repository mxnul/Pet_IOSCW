//
//  LocationManager.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-24.
//

//import SwiftUI
//import MapKit
//import CoreLocation
//import FirebaseFirestore
//
//// LocationManager to handle location fetching
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let locationManager = CLLocationManager()
//
//    @Published var location: CLLocation? = nil
//    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default region (San Francisco)
//        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//    )
//
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//    }
//
//    func requestLocation() {
//        // Check if location services are enabled
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.requestWhenInUseAuthorization()
//            locationManager.requestLocation()
//        } else {
//            print("Location services are not enabled")
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let newLocation = locations.first {
//            self.location = newLocation
//            self.region.center = newLocation.coordinate
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("❌ Failed to get location: \(error.localizedDescription)")
//    }
//}
