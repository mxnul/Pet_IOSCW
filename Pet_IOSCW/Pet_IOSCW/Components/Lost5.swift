//
//  Lost5.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-21.
//

import SwiftUI
import FirebaseFirestore

struct Lost5: View {
    var petDocumentID: String
    @State private var contactNumber = ""
    @State private var showSuccessAlert = false
    @State private var navigateToMainTab = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Enter Your Contact Number")
                    .font(.title2)
                    .foregroundColor(.white)

                HStack {
                    Text("+94")
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.white)

                    TextField("Enter number", text: $contactNumber)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .keyboardType(.numberPad)
                        .foregroundColor(.white)
                }

                Spacer()

                Button("Post") {
                    saveContactNumber()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.black)
                .background(Color.customLightGray)
                .cornerRadius(10)
                
                // NavigationLink triggered programmatically
                NavigationLink(destination: MainTabView(), isActive: $navigateToMainTab) {
                    EmptyView()
                }
            }
            .padding()
            .background(Color.black.ignoresSafeArea())
            .alert("Posted Successfully", isPresented: $showSuccessAlert) {
                Button("OK") {
                    navigateToMainTab = true
                }
            }
        }
    }

    // MARK: - Firestore Update
    func saveContactNumber() {
        let db = Firestore.firestore()
        db.collection("lost_pets").document(petDocumentID).updateData([
            "contactNumber": "+94\(contactNumber)"
        ]) { error in
            if let error = error {
                print("❌ Failed to save contact: \(error.localizedDescription)")
            } else {
                print("✅ Contact number saved")
                showSuccessAlert = true
            }
        }
    }
}

#Preview {
    Lost5(petDocumentID: "sampleDocID")
}
