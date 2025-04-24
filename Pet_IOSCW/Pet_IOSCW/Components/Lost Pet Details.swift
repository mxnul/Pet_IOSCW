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
