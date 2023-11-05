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
        
        return false
    }
    
    func croppedImage(from originalImage: CIImage, rectangleObservation: VNRectangleObservation) -> UIImage? {
        
        return nil
    }
}
