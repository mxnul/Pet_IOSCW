//
//  Lost1.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-19.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct Lost1: View {
    @Environment(\.dismiss) var dismiss

    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImageDataList: [Data] = []
    @State private var petName = ""
    @State private var description = ""
    @State private var isUploading = false

    @State private var navigateToLost2 = false
    @State private var createdDocID: String? = nil

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // Back button
                    HStack {
                        Button("< Back") { dismiss() }
                            .foregroundColor(.customLightGray)
                            .padding(.top, 50)
                        Spacer()
                    }.padding()

                    // Title
                    Text("Add Pet Details")
                        .font(.title)
                        .bold()
                        .foregroundColor(.customLightGray)
                        .padding(.top, 20)

                    // Image Picker
                    PhotosPicker(selection: $selectedItems, maxSelectionCount: 5, matching: .images) {
                        Label("Select Pet Photos", systemImage: "photo.on.rectangle")
                            .frame(width: 350, height: 50)
                            .background(Capsule().stroke(lineWidth: 2))
                            .foregroundColor(.white)
                            .padding(.top, 30)
                    }
                    .onChange(of: selectedItems) { newItems in
                        selectedImageDataList = []
                        Task {
                            for item in newItems {
                                if let data = try? await item.loadTransferable(type: Data.self) {
                                    selectedImageDataList.append(data)
                                }
                            }
                        }
                    }

                    // Image Preview
                    if !selectedImageDataList.isEmpty {
                        TabView {
                            ForEach(selectedImageDataList, id: \.self) { imageData in
                                if let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 300, height: 200)
                                        .clipped()
                                        .cornerRadius(16)
                                        .padding(.horizontal)
                                }
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .frame(height: 320)
                    }

                    // Pet Name
                    TextField("Enter Pet Name", text: $petName)
                        .padding()
                        .foregroundColor(.customLightGray)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.customLightGray, lineWidth: 1))
                        .padding(.top, 30)

                    // Description
                    TextEditor(text: $description)
                        .frame(height: 150)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customLightGray, lineWidth: 1)
                        )
                        .padding(.bottom, 40)

                    // Upload Button
                    Button(action: savePetDetails) {
                        if isUploading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        } else {
                            Text("Next >")
                                .bold()
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.customLightGray)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .disabled(isUploading)

                    NavigationLink(
                        destination: createdDocID.map { Lost2(petDocumentID: $0) },
                        isActive: $navigateToLost2
                    ) {
                        EmptyView()
                    }


                }
                .padding()
            }
            .background(Color.black.ignoresSafeArea())
        }
    }

    // MARK: - Save Pet Details to Firebase
    func savePetDetails() {
        guard !petName.isEmpty, !description.isEmpty else {
            print("⚠️ Pet name or description missing.")
            return
        }

        isUploading = true

        uploadImages(images: selectedImageDataList) { urls in
            let db = Firestore.firestore()
            var ref: DocumentReference? = nil

            ref = db.collection("lost_pets").addDocument(data: [
                "petName": petName,
                "description": description,
                "imageUrls": urls,
                "timestamp": Timestamp(date: Date())
            ]) { error in
                isUploading = false
                if let error = error {
                    print("❌ Firestore error: \(error.localizedDescription)")
                } else if let docID = ref?.documentID {
                    print("✅ Pet data saved. Doc ID: \(docID)")
                    createdDocID = docID
                    navigateToLost2 = true
                }
            }
        }
    }

    // MARK: - Upload Images to Firebase Storage
    func uploadImages(images: [Data], completion: @escaping ([String]) -> Void) {
        guard !images.isEmpty else {
            completion([])
            return
        }

        let storage = Storage.storage()
        var uploadedURLs: [String] = []
        let dispatchGroup = DispatchGroup()

        for imageData in images {
            dispatchGroup.enter()
            let fileName = UUID().uuidString + ".jpg"
            let ref = storage.reference().child("pet_photos/\(fileName)")
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"

            ref.putData(imageData, metadata: metadata) { _, error in
                if let error = error {
                    print("❌ Upload failed: \(error.localizedDescription)")
                    dispatchGroup.leave()
                    return
                }

                ref.downloadURL { url, error in
                    if let url = url {
                        uploadedURLs.append(url.absoluteString)
                    } else {
                        print("❌ Couldn't get download URL: \(error?.localizedDescription ?? "")")
                    }
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            print("✅ All images uploaded: \(uploadedURLs)")
            completion(uploadedURLs)
        }
    }
}

#Preview {
    Lost1()
}

