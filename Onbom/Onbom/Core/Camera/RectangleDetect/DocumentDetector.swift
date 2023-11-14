//
//  DocumentDetector.swift
//  Onbom
//
//  Created by Junyoo on 11/1/23.
//

import Vision
import UIKit

class DocumentDetector: RectangleDetectable {
    var detectedRectangle: VNRectangleObservation?

//    func isRectangleInsideGuideline(_ observation: VNRectangleObservation) -> Bool {
//        let guideX = observation.boundingBox.origin.x
//        let guideY = observation.boundingBox.origin.y
//        
//        return (0.35...0.38).contains(guideX) && (0.09...0.12).contains(guideY)
//    }

    func detectRectangle(from image: CIImage) -> Bool {
        var isRectangleDetected = false
        // TODO: guard let 시도하기
        let request = VNDetectRectanglesRequest { (request, error) in
            if let results = request.results as? [VNRectangleObservation], !results.isEmpty {
                for observation in results {
//                    if self.isRectangleInsideGuideline(observation) {
                        isRectangleDetected = true
                        self.detectedRectangle = observation
//                        break
//                    }
                }
            }
        }
        
        request.minimumAspectRatio = 1.4
        request.maximumAspectRatio = 1.5
        request.minimumSize = 0.40
        request.minimumConfidence = 0.9

        let handler = VNImageRequestHandler(ciImage: image, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("IDCardDetector failed to detect: \(error.localizedDescription)")
        }
        return isRectangleDetected
    }
        
    func croppedImage(from originalImage: CIImage, rectangleObservation: VNRectangleObservation) -> UIImage? {
        let imageSize = originalImage.extent.size
        let boundingBox = rectangleObservation.boundingBox
        let croppedCIImage = originalImage.cropped(to: CGRect(
            x: boundingBox.origin.x * imageSize.width,
            y: (1 - boundingBox.origin.y - boundingBox.height) * imageSize.height,
            width: boundingBox.width * imageSize.width,
            height: boundingBox.height * imageSize.height
        ))
        
        if let cgImage = CIContext().createCGImage(croppedCIImage, from: croppedCIImage.extent) {
            let rotatedImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .right)
            return rotatedImage
        }
        return nil
    }
}
