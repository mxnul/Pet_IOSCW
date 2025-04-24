//
//  Lost Pet.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-24.
//

import Foundation
import CoreLocation
import FirebaseFirestore

struct LostPet: Identifiable, Codable {
    @DocumentID var id: String?
    var petName: String
    var description: String
    var imageUrls: [String]
    var lastSeenLocation: String
    var coordinates: GeoPoint
    var contactNumber: String
    var timestamp: Date
}
