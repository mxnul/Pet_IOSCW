//
//  Vets.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-21.
//

import SwiftUI

struct VetService: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

let vetServices = [
    VetService(title: "Bathing & Drying", imageName: "bathtub"),
    VetService(title: "Hair Trimming", imageName: "scissors"),
    VetService(title: "Nail Trimming", imageName: "pawprint"),
    VetService(title: "Ear Cleaning", imageName: "ear"),
    VetService(title: "Teeth Brushing", imageName: "mouth"),
    VetService(title: "Flea Treatment", imageName: "ant")
]

struct Vets: View {
    @State private var searchText = ""
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var filteredServices: [VetService] {
        searchText.isEmpty ? vetServices : vetServices.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
               
                HStack {
                    Button(action: {  }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(.trailing, 8)
                       
                    }
                    Spacer()
                }
                
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("60% OFF")
                            .font(.headline)
                            .foregroundColor(.black)
                        Text("On hair & spa treatment")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                
               
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search", text: $searchText)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color(.systemGray5).opacity(0.12))
                .cornerRadius(12)
                
                
                Text("Our Services")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                    .padding(.top, 8)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(filteredServices) { service in
                        VStack(spacing: 8) {
                            ZStack {
                                Color.white
                                    .cornerRadius(16)
                                Image(systemName: service.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.gray)
                            }
                            .frame(height: 90)
                            
                            Text(service.title)
                                .foregroundColor(.white)
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .navigationBarHidden(true)
    }
}

struct VetsView_Previews: PreviewProvider {
    static var previews: some View {
        Vets()
    }
}
