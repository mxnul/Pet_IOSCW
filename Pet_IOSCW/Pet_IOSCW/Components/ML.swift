//
//  ML.swift
//  Pet_IOSCW
//
//  Created by Manula 048 on 2025-04-22.
//

import CoreML
import Vision

//func analyzeImage(imageData: Data) {
//    guard let model = try? VNCoreMLModel(for: MobileNetV2().model) else { return }
//    let request = VNCoreMLRequest(model: model) { request, error in
//        if let results = request.results as? [VNClassificationObservation] {
//            // Process results
//            imageTags = results.prefix(5).map { $0.identifier }
//        }
//    }
//    guard let ciImage = CIImage(data: imageData) else { return }
//    let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
//    try? handler.perform([request])
//}
