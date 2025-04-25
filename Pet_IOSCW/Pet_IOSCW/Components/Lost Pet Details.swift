//
//  Lost Pet Details.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-24.
//

import SwiftUI

struct LostPetDetailView: View {
    let pet: LostPet
    @Binding var isPresented: LostPet?
    
    var body: some View {
        VStack(spacing: 12) {
            Capsule()
                .fill(Color.gray)
                .frame(width: 40, height: 5)
                .padding(.top, 10)

            Text(pet.petName)
                .font(.title)
                .bold()
                .foregroundColor(.white)

            TabView {
                ForEach(pet.imageUrls, id: \.self) { urlString in
                    AsyncImage(url: URL(string: urlString)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .cornerRadius(12)
                }
            }
            .frame(height: 260)
            .tabViewStyle(PageTabViewStyle())

            // New Tags Section
            if let tags = pet.tags, !tags.isEmpty {
                VStack(alignment: .leading) {
                    Text("Special Features")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(tags, id: \.self) { tag in
                                Text(tag)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.customLightGray.opacity(0.3))
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 8)
            }

            Text("Description: \(pet.description)")
                .foregroundColor(.white)
                .padding(.horizontal)

            Text("Last Seen: \(pet.lastSeenLocation)")
                .foregroundColor(.white)

            Text("Contact: \(pet.contactNumber)")
                .foregroundColor(.white)

            Button("Close") {
                isPresented = nil
            }
            .padding()
            .background(Color.customLightGray)
            .foregroundColor(.black)
            .cornerRadius(10)

            Spacer()
        }
        .padding()
        .background(Color.black)
        .cornerRadius(16)
        .padding()
    }
}
