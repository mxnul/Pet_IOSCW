//
//  Lost2 2.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-23.
//


import SwiftUI
import MapKit

struct Lost2: View {
    @State private var searchText = ""
    @State private var recentLocations: [String] = []
    @State private var selectedLocation: String? = nil
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Pet Location")
                .font(.title)
                .foregroundColor(.white)
                .padding(.top)
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Enter Last Seen Location", text: $searchText, onCommit: {
                    selectLocation(searchText)
                })
                .focused($isSearchFocused)
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(10)

            // Show recent locations when search is focused
            if isSearchFocused && !recentLocations.isEmpty {
                ForEach(recentLocations, id: \.self) { location in
                    Button(action: {
                        searchText = location
                        selectLocation(location)
                        isSearchFocused = false
                    }) {
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(.gray)
                            Text(location)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                }
            }

            HStack {
                Image(systemName: "location.fill")
                    .foregroundColor(.green)
                Button("My Current Location") {
                    // Simulate setting the region to user's current location
                    // Replace with CoreLocation usage in real app
                    region.center = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
                    selectedLocation = "My Current Location"
                }
                .foregroundColor(.white)
                Spacer()
                Image(systemName: "pause.circle")
                    .foregroundColor(.white)
            }
            .padding(.vertical)
            
            Text("Popular Locations")
                .foregroundColor(.gray)
                .padding(.top)
            
            ForEach(["Washington", "Park", "Stadium", "Art Gallery", "Raven Park"], id: \.self) { location in
                Button(action: {
                    searchText = location
                    selectLocation(location)
                }) {
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.pink)
                        Text(location)
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "star")
                            .foregroundColor(.yellow)
                    }
                    .padding(.vertical, 5)
                }
            }
            
            Map(coordinateRegion: $region)
                .frame(height: 200)
                .cornerRadius(10)
            
            Spacer()
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }
    
    func selectLocation(_ location: String) {
        // Example: you’d use geocoding to get coordinates
        // For demo, we'll just use hardcoded coordinates
        if location.lowercased().contains("park") {
            region.center = CLLocationCoordinate2D(latitude: 37.7694, longitude: -122.4862)
        } else if location.lowercased().contains("stadium") {
            region.center = CLLocationCoordinate2D(latitude: 37.4021, longitude: -121.9680)
        } else {
            region.center = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        }

        if !recentLocations.contains(location) {
            recentLocations.insert(location, at: 0)
            if recentLocations.count > 5 {
                recentLocations.removeLast()
            }
        }
        selectedLocation = location
    }
}

#Preview {
    Lost3()
}