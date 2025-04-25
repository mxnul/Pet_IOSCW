//
//  Home.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-19.
//

import SwiftUI
import MapKit
import FirebaseFirestore


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
                MapAnnotation(coordinate: pet.locationCoordinate) {
                    Button {
                        selectedPet = pet
                    } label: {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                            .frame(width: 40, height: 40)
                            .background(Circle().fill(Color.white).shadow(radius: 5))
                            .clipShape(Circle())
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
        db.collection("lost_pets")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("❌ Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                lostPets = documents.compactMap { doc in
                    do {
                        return try doc.data(as: LostPet.self)
                    } catch {
                        print("🔥 DECODING ERROR: \(error)")
                        print("🔥 DOCUMENT DATA: \(doc.data())")
                        return nil
                    }
                }
            }
    }
}

#Preview {
    MainTabView()
}

