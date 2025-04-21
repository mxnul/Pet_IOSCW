//
//  Lost3.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-21.
//

import SwiftUI

struct Lost3: View {
    @State private var searchText = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Pet Location")
                .font(.title)
                .foregroundColor(.white)
                .padding(.top)
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Enter Last Seen Location", text: $searchText)
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(10)
            
            HStack {
                Image(systemName: "location.fill")
                    .foregroundColor(.green)
                Text("My Current Location")
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "pause.circle")
                    .foregroundColor(.white)
            }
            .padding(.vertical)
            
            Text("Popular Locations")
                .foregroundColor(.gray)
                .padding(.top)
            
            ForEach(["washington", "park", "Stadium", "Art Gallery", "raven park"], id: \.self) { location in
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
            
            Spacer()
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }
}

#Preview {
    Lost3()
}
