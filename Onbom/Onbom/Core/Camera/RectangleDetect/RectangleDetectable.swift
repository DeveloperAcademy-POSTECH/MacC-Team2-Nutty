//
//  RectangleDetectable.swift
//  Onbom
//
//  Created by Junyoo on 11/1/23.
//

import UIKit
import Vision

protocol RectangleDetectable {
    var detectedRectangle: VNRectangleObservation? { get }
    func detectRectangle(from image: CIImage) -> Bool
    func croppedImage(from originalImage: CIImage, rectangleObservation: VNRectangleObservation) -> UIImage?
}
