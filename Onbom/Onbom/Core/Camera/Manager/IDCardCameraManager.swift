//
//  IDCardCameraManager.swift
//  Onbom
//
//  Created by Junyoo on 11/1/23.
//

import UIKit
import AVFoundation

class IDCardCameraManager: CameraManager {
    private var textRecognizer: TextRecognizable
    private let videoDataOutput = AVCaptureVideoDataOutput()
    var capturedIDCard: ((UIImage) -> Void)?
    var recognizedID: ((String) -> Void)?
    
    init(textRecognizer: TextRecognizable = IDCardTextRecognizer()) {
        self.textRecognizer = textRecognizer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupCamera() {
        super.setupCamera()
    }
    
    override func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        super.photoOutput(output, didFinishProcessingPhoto: photo, error: error)
        
        guard let data = photo.fileDataRepresentation(), let fullImage = UIImage(data: data) else {
            print("IDCardCameraManager failed to get image data")
            return
        }
        
        guard let croppedImage = processCropImage(fullImage) else {
            print("IDCardCameraManager failed to croppedImage")
            return
        }
        
        recognizeText(from: croppedImage)
    }
    
    private func processCropImage(_ image: UIImage) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        return cropImage(from: ciImage)
    }
    
    private func cropImage(from originalImage: CIImage) -> UIImage? {
        let imageSize = originalImage.extent.size
        print(imageSize)
        let cropRect = CGRect(
            x: imageSize.width * 0.35,
            y: imageSize.height * 0.1,
            width: imageSize.height * 0.5,
            height: imageSize.width * 0.45
        )
        
        let croppedCIImage = originalImage.cropped(to: cropRect)
        
        if let cgImage = CIContext().createCGImage(croppedCIImage, from: croppedCIImage.extent) {
            let rotatedImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .right)
            return rotatedImage
        }
        return nil
    }
    
    private func recognizeText(from image: UIImage) {
        textRecognizer.recognizeText(from: image) { [weak self] recognizedID in
            if let id = recognizedID {
                self?.recognizedID?(id)
            } else {
                print("Failed to recognize text from the image")
            }
        }
        capturedIDCard?(image)
    }
}
