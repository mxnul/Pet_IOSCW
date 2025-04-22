//
//  Home.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-19.
//

import SwiftUI
import MapKit

struct Home: View {
    @State private var searchText = ""
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    @State private var selectedTab: MainTabView.Tab = .home

    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(.customLightGray)
                    Text("Hello, Sarah").bold()
                        .foregroundColor(.customLightGray)
                    Spacer()
                    Image(systemName: "bell")
                        .foregroundColor(.customLightGray)
                }
                .padding()

                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Enter Last Seen Location", text: $searchText)
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)

                Map(coordinateRegion: $region, annotationItems: sampleLocations) { location in
                    MapMarker(coordinate: location.coordinate, tint: Color.red)
                }
                .frame(height: 600)
                .cornerRadius(20)

                Spacer()
            }

//            // Attach the custom tab bar at the bottom
//            CustomTabBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.black)
    }
}
struct Location : Identifiable {
    let id = UUID()
    let coordinate : CLLocationCoordinate2D
}

let sampleLocations = [
    Location (coordinate: CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612))
]

#Preview {
    MainTabView()
}
