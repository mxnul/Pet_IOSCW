//
//  Lost4.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-21.
//


import SwiftUI

import MapKit

struct Lost4: View {
    @State private var region = MKCoordinateRegion(
                center : CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612),
                span: MKCoordinateSpan( latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
    var body: some View {
        VStack (alignment: .leading) {
            Text("Pet Location")
                .font(.title)
                .foregroundColor(.white)
                .padding(.top)
            
            HStack {
//                Image(systemName: "magnifyingglass")
//                TextField("Enter Last Seen Location", text: $searchText)
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(10)
            
            
            
        }
    }
}


#Preview {
    Lost4()
}
