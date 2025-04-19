//
//  Home.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-19.
//

import SwiftUI

import MapKit

struct Home : View {
    @State private var region = MKCoordinateRegion(
                center : CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612),
                span: MKCoordinateSpan( latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "person.circle.fill")
                Text("Hello, Sarah") .bold()
                Spacer()
                Image (systemName: "bell")
            }
            .padding()
            
            TextField("Search Maps", text: .constant(""))
                .padding()
                .background()
                .cornerRadius(10)
                .padding(.horizontal)
            
            Map (coordinateRegion: $region, annotationItems: sampleLocations) { location in MapMarker(coordinate: location.coordinate, tint: Color.red)}
        }
        .frame(height: 400)
        
        Spacer()
        
        HStack {
            Spacer()
            Button("Lost Pet"){
                
            }
            Spacer()
        }
        .padding()

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
    Home()
}
