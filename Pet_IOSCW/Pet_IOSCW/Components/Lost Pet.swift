//
//  Lost Pet.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-24.
//
import Foundation
import FirebaseFirestore
import MapKit
import FirebaseFirestore

struct LostPet: Identifiable, Codable {
    @DocumentID var id: String?
    var petName: String
    var description: String
    var imageUrls: [String]
    var lastSeenLocation: String
    var coordinates: [String: Double]
    var contactNumber: String
    var tags: [String]? 
    var timestamp: Date
    
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates["latitude"] ?? 0,
            longitude: coordinates["longitude"] ?? 0
        )
    }
}
