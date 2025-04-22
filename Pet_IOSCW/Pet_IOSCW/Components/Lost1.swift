//
//  Lost1.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-19.
//

import SwiftUI
import PhotosUI

struct Lost1: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImageDataList: [Data] = []
    @State private var petName = ""
    @State private var description = ""
    @State private var imageTags: [String] = []

    var body: some View {
        VStack {
            // Back Button
            HStack {
                Button(" < Back") {
                    // handle back
                }
                .foregroundColor(.customLightGray)
                .padding(.top, 50)
                Spacer()
            }
            .padding()

            // Title
            HStack {
                Text("Add Pet Details")
                    .font(.title)
                    .bold()
                    .foregroundColor(.customLightGray)
                    .padding(.top, 20)
                Spacer()
            }

            // Photo Picker Button
            PhotosPicker(
                selection: $selectedItems,
                maxSelectionCount: 5,
                matching: .images,
                photoLibrary: .shared()
            ) {
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
                            analyzeImage(imageData: data)
                        }
                    }
                }
            }

            // Swipeable Images
            if !selectedImageDataList.isEmpty {
                TabView {
                    ForEach(selectedImageDataList, id: \.self) { imageData in
                        if let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 300)
                                .clipped()
                                .cornerRadius(16)
                                .padding(.horizontal)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 320)
            }

            // Pet Name Field
            TextField("Enter Pet Name", text: $petName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 30)
                .padding(.bottom, 20)

            // Description Field
            TextField("Start typing", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.customLightGray))

            Spacer()

            VStack {
                Button("Next >") {
                    savePetDetails()
                }
            }
            .padding()
            .foregroundColor(.customLightGray)
        }
        .padding()
        .background(Color.black)
        .foregroundColor(.white)
        .ignoresSafeArea()
    }

    // MARK: - Core ML Placeholder
    func analyzeImage(imageData: Data) {
        // Drop in your Core ML code here
        // imageTags.append("blue collar")
    }

    // MARK: - Firebase Upload Placeholder
    func savePetDetails() {
        guard !selectedImageDataList.isEmpty else {
            print("No images selected.")
            return
        }

        print("Pet Name: \(petName)")
        print("Description: \(description)")
        print("Images count: \(selectedImageDataList.count)")
        print("Tags: \(imageTags)")
        // Upload images and save metadata to Firebase
    }
}

#Preview {
    Lost1()
}
