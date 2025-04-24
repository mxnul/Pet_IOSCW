////
////  Lost3 2.swift
////  Pet_IOSCW
////
////  Created by Manula 048 on 2025-04-23.
////
//
import SwiftUI
import MapKit
import CoreLocation
import FirebaseFirestore

struct Lost2: View {
    var petDocumentID: String
    @State private var searchText = ""
    @State private var recentLocations: [String] = []
    @State private var selectedLocation: String? = nil
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @FocusState private var isSearchFocused: Bool
    @State private var isSaving = false
    @State private var navigateToLost5 = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Enter Last Seen Location", text: $searchText, onCommit: {
                        selectLocation(searchText)
                        isSearchFocused = false
                    }).focused($isSearchFocused)
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                .padding(.top)

                if isSearchFocused && !recentLocations.isEmpty {
                    ForEach(recentLocations, id: \.self) { location in
                        Button {
                            searchText = location
                            selectLocation(location)
                            isSearchFocused = false
                        } label: {
                            HStack {
                                Image(systemName: "clock")
                                Text(location)
                                Spacer()
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 4)
                        }
                    }
                }

                if selectedLocation == nil {
                    Text("Pet Location")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.top)

                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.green)
                        Button("My Current Location") {
                            getCurrentLocation()
                        }
                        .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.vertical)

                    Text("Popular Locations")
                        .foregroundColor(.gray)

                    ForEach(["Washington", "Park", "Stadium", "Art Gallery", "Raven Park"], id: \.self) { location in
                        Button {
                            searchText = location
                            selectLocation(location)
                        } label: {
                            HStack {
                                Image(systemName: "mappin.circle.fill").foregroundColor(.pink)
                                Text(location)
                                Spacer()
                                Image(systemName: "star").foregroundColor(.yellow)
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                        }
                    }
                }

                Map(coordinateRegion: $region)
                    .frame(height: 400)
                    .cornerRadius(10)
                    .padding(.vertical)

                Button(action: saveLocation) {
                    if isSaving {
                        ProgressView()
                    } else {
                        Text("Next >").bold()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.customLightGray)
                .foregroundColor(.black)
                .cornerRadius(10)

                NavigationLink(destination: Lost5(petDocumentID: petDocumentID), isActive: $navigateToLost5) {
                    EmptyView()
                }
                
               

                Spacer()
            }
            .padding()
            .background(Color.black.ignoresSafeArea())
        }
    }

    func selectLocation(_ location: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { placemarks, error in
            if let coordinate = placemarks?.first?.location?.coordinate {
                region.center = coordinate
                selectedLocation = location
                if !recentLocations.contains(location) {
                    recentLocations.insert(location, at: 0)
                    if recentLocations.count > 5 {
                        recentLocations.removeLast()
                    }
                }
            } else {
                print("❌ Geocoding failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    func getCurrentLocation() {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        if let location = manager.location {
            region.center = location.coordinate
            selectedLocation = "Current Location"

            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, _ in
                if let name = placemarks?.first?.name {
                    selectedLocation = name
                }
            }
        }
    }

    func saveLocation() {
        guard let selectedLocation = selectedLocation else {
            print("❌ No location selected.")
            return
        }

        isSaving = true
        let db = Firestore.firestore()

        db.collection("lost_pets").document(petDocumentID).updateData([
            "lastSeenLocation": selectedLocation,
            "coordinates": [
                "latitude": region.center.latitude,
                "longitude": region.center.longitude
            ]
        ]) { error in
            isSaving = false
            if let error = error {
                print("❌ Firestore update failed: \(error.localizedDescription)")
            } else {
                print("✅ Location updated successfully.")
                navigateToLost5 = true
            }
        }
    }
}

#Preview {
    Lost2(petDocumentID: "sampleDocID")
}
