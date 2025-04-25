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


let colomboRegion = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612),
    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
)


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    @Published var location: CLLocation? = nil
    @Published var region: MKCoordinateRegion = colomboRegion
    @Published var showCurrentLocationPin: Bool = false

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }

    func requestLocation() {
        if CLLocationManager.locationServicesEnabled() {
            manager.requestWhenInUseAuthorization()
            manager.requestLocation()
        } else {
            print("❌ Location services are not enabled.")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.first {
            self.location = newLocation
            self.region = MKCoordinateRegion(
                center: newLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            self.showCurrentLocationPin = true
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ Failed to get location: \(error.localizedDescription)")
    }
}


struct LocationPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}


struct Lost2: View {
    var petDocumentID: String
    @Environment(\.dismiss) private var dismiss

    @StateObject private var locationManager = LocationManager()
    @State private var searchText = ""
    @State private var recentLocations: [String] = []
    @State private var selectedLocation: String? = nil
    @FocusState private var isSearchFocused: Bool
    @State private var isSaving = false
    @State private var navigateToLost5 = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
               
                Button(action: { dismiss() }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.customLightGray)
                        Text("Back")
                            .foregroundColor(.customLightGray)
                    }
                    .padding(.bottom, 10)
                }
                
                if selectedLocation == nil {
                    Text("Pet Location")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.top)

                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.green)
                        Button("Use My Current Location") {
                            locationManager.requestLocation()
                        }
                        .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.vertical)
                }
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                    
                    TextField("", text: $searchText, onCommit: {
                        selectLocation(searchText)
                        isSearchFocused = false
                    })
                    .focused($isSearchFocused)
                    .placeholder(when: searchText.isEmpty) {
                        Text("Enter Last Seen Location")
                            .foregroundColor(.gray)
                    }
                    .foregroundColor(.white)
                }
                .padding()
                .background(Color.black)
                .cornerRadius(10)
                .padding(.top)

               
                Map(
                    coordinateRegion: $locationManager.region,
                    annotationItems: locationManager.showCurrentLocationPin && locationManager.location != nil ?
                        [LocationPin(coordinate: locationManager.location!.coordinate)] : []
                ) { pin in
                    MapAnnotation(coordinate: pin.coordinate) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                    }
                }
                .frame(height: 400)
                .cornerRadius(10)
                .padding(.vertical)
                .padding(.bottom, 40)

               
                Button(action: saveLocation) {
                    if isSaving {
                        ProgressView()
                    } else {
                        Text("Next ").bold()
                    }
                }
                
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.customLightGray)
                .foregroundColor(.black)
                .cornerRadius(20)

              
                NavigationLink(destination: Lost5(petDocumentID: petDocumentID), isActive: $navigateToLost5) {
                    EmptyView()
                }

                Spacer()
            }
            .padding()
            .background(Color.black.ignoresSafeArea())
        }
        .navigationBarBackButtonHidden(true)
    }

    
    func selectLocation(_ location: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { placemarks, error in
            if let coordinate = placemarks?.first?.location?.coordinate {
                locationManager.region.center = coordinate
                selectedLocation = location
                locationManager.showCurrentLocationPin = true
                locationManager.location = placemarks?.first?.location
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

    
    func saveLocation() {
        guard let location = locationManager.location else {
            print("❌ Location is not available.")
            return
        }

        selectedLocation = "User's Current Location"
        isSaving = true

        let db = Firestore.firestore()
        db.collection("lost_pets").document(petDocumentID).updateData([
            "lastSeenLocation": selectedLocation ?? "Unknown",
            "coordinates": [
                "latitude": location.coordinate.latitude,
                "longitude": location.coordinate.longitude
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


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}


#Preview {
    Lost2(petDocumentID: "sampleDocID")
}
