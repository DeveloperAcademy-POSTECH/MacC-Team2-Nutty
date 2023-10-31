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

    func detectRectangle(from image: CIImage) -> Bool {
        var isRectangleDetected = false
        let request = VNDetectRectanglesRequest { (request, error) in
            if let results = request.results as? [VNRectangleObservation], !results.isEmpty {
                for observation in results {
                    isRectangleDetected = true
                    self.detectedRectangle = observation
                    break
                }
            }
        }
        
        //값 수정
        request.minimumAspectRatio = 0.6
        request.maximumAspectRatio = 0.65
        request.minimumSize = 0.45
        request.minimumConfidence = 1.0

        let handler = VNImageRequestHandler(ciImage: image, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("DocumentDetector failed to detect: \(error.localizedDescription)")
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
