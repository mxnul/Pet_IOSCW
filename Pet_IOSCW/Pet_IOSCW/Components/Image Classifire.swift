//
//  Image Classifire.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-25.
//

import Foundation
import CoreML
import Vision
import UIKit
import SwiftUI

class ImageClassifier {
    private let model: VNCoreMLModel

    init() {
        do {
            model = try VNCoreMLModel(for: MobileNetV2().model)
        } catch {
            fatalError("Failed to load MobileNetV2 model: \(error)")
        }
    }

    func classify(image: UIImage, completion: @escaping ([String]) -> Void) {
        guard let cgImage = image.cgImage else {
            completion([])
            return
        }

        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                completion([])
                return
            }
        
            let tags = results.prefix(5).map { $0.identifier }
            completion(tags)
        }

        let handler = VNImageRequestHandler(cgImage: cgImage)
        DispatchQueue.global(qos: .userInitiated).async {
            try? handler.perform([request])
        }
    }
}
