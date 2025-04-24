//
//  Home.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-19.
//

import SwiftUI
import MapKit
import FirebaseFirestore
//import FirebaseFirestoreSwift

struct Home: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var lostPets: [LostPet] = []
    @State private var selectedPet: LostPet? = nil

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: lostPets) { pet in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: pet.coordinates.latitude, longitude: pet.coordinates.longitude)) {
                    Button {
                        selectedPet = pet
                    } label: {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)

            if let pet = selectedPet {
                LostPetDetailView(pet: pet, isPresented: $selectedPet)
                    .transition(.move(edge: .bottom))
            }
        }
        .onAppear(perform: fetchLostPets)
        .background(Color.black.ignoresSafeArea())
    }

    func fetchLostPets() {
        let db = Firestore.firestore()
        db.collection("lost_pets").order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("❌ Error fetching lost pets: \(error?.localizedDescription ?? "")")
                return
            }

            do {
                lostPets = try documents.compactMap {
                    try $0.data(as: LostPet.self)
                }
            } catch {
                print("❌ Decoding error: \(error)")
            }
        }
    }
}
#Preview {
    MainTabView()
}

