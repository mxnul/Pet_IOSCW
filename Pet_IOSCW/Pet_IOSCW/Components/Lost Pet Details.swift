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
    @State private var navigateToSpot2 = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Button(action: {
                    isPresented = nil
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding(8)
//                        .padding(.left, 200)
                        .background(Circle().fill(Color.red))
                }
                .padding(.horizontal, 200)
                Capsule()
                    .fill(Color.gray)
                    .frame(width: 40, height: 5)
                    .padding(.top, 10)
                
                
                ZStack(alignment: .topTrailing) {
                    VStack(spacing: 12) {
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
                        
                        NavigationLink(destination: Spot2(), isActive: $navigateToSpot2) {
                            EmptyView()
                        }
                        
                        Button("Spotted") {
                            navigateToSpot2 = true
                        }
                        .frame(width: 350)
                        .padding()
                        .background(Color.customLightGray)
                        .foregroundColor(.black)
                       
                        .cornerRadius(10)
                        .padding(.top, 80)
                        
                        Spacer()
                    }
                    
                  
                   
                    .padding(.top, 10)
                }
            }
            .padding()
            .background(Color.black)
            .cornerRadius(16)
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}


struct Spot2View: View {
    var body: some View {
        Text("Spot2 View Content")
            .foregroundColor(.white)
            .background(Color.black)
    }
}
