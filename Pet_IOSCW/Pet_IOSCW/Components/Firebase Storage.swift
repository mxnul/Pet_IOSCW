//
//  Firebase Storage.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-22.
//

//import FirebaseStorage
//
//func uploadImage(imageData: Data, completion: @escaping (URL?) -> Void) {
//    let storage = Storage.storage()
//    let storageRef = storage.reference()
//    let imageRef = storageRef.child("pet_photos/\(UUID().uuidString).jpg")
//    let metadata = StorageMetadata()
//    metadata.contentType = "image/jpeg"
//
//    imageRef.putData(imageData, metadata: metadata) { metadata, error in
//        if let error = error {
//            print("Error uploading image: \(error.localizedDescription)")
//            completion(nil)
//            return
//        }
//        imageRef.downloadURL { url, error in
//            if let error = error {
//                print("Error retrieving download URL: \(error.localizedDescription)")
//                completion(nil)
//                return
//            }
//            completion(url)
//        }
//    }
//}
