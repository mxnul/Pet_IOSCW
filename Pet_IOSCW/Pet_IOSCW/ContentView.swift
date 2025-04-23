//
//  ContentView.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-11.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 6.9533, longitude: 79.8704),
            latitudinalMeters: 1300,
            longitudinalMeters: 1300
        )
    )
    var body: some View {
        Map(initialPosition: cameraPosition){
            
        }
    }
}

#Preview {
    MainTabView()
}
