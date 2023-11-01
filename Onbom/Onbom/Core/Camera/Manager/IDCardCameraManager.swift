//
//  IDCardCameraManager.swift
//  Onbom
//
//  Created by Junyoo on 11/1/23.
//

import UIKit
import AVFoundation

class IDCardCameraManager: CameraManager {
    private var rectangleDetector = IDCardDetector()
    private var textRecognizer = IDCardTextRecognizer()
    private let videoDataOutput = AVCaptureVideoDataOutput()
    var capturedIDCard: ((UIImage) -> Void)?
    var recognizedID: ((String) -> Void)?

    override func setupCamera() {
        super.setupCamera()

        if captureSession.canAddOutput(videoDataOutput) {
            captureSession.addOutput(videoDataOutput)
            videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
        }
        print("setupCamera")
    }
    
    override func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        super.photoOutput(output, didFinishProcessingPhoto: photo, error: error)
        
        guard let data = photo.fileDataRepresentation(), let fullImage = UIImage(data: data) else {
            print("IDCardCameraManager failed to get image data")
            return
        }
        
        guard let croppedImage = processCapturedImage(fullImage) else {
            print("IDCardCameraManager failed to croppedImage")
            return
        }
        
        recognizeText(from: croppedImage)
    }
    
    private func processCapturedImage(_ image: UIImage) -> UIImage? {
        guard let rectangleObservation = rectangleDetector.detectedRectangle,
              let ciImage = CIImage(image: image) else {
            return nil
        }
        
        return rectangleDetector.croppedImage(from: ciImage, rectangleObservation: rectangleObservation)
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

extension IDCardCameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let image = CIImage(cvPixelBuffer: imageBuffer)
        if rectangleDetector.detectRectangle(from: image) {
            takePhoto()
        }
    }
}
