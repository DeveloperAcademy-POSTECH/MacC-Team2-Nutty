//
//  CameraManager.swift
//  Onbom
//
//  Created by Junyoo on 2023/09/28.
//

import UIKit
import AVFoundation

class CameraManager: UIViewController {
    private let captureSession = AVCaptureSession()
    private var photoOutput = AVCapturePhotoOutput()
    private var previewLayer = AVCaptureVideoPreviewLayer()
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private let rectangleDetector = RectangleDetector()
    private let textRecognizer = TextRecognizer()
    private var isTaken = false
    var capturedIDCard: ((UIImage) -> Void)?
    var recognizedNameID: ((NameID) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isTaken = false
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession.stopRunning()
    }
    
    private func setupCamera() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            
            if captureSession.canAddOutput(photoOutput) {
                captureSession.addOutput(photoOutput)
            }
            
            if captureSession.canAddOutput(videoDataOutput) {
                captureSession.addOutput(videoDataOutput)
                videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
                videoDataOutput.alwaysDiscardsLateVideoFrames = true
            }
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = view.bounds
            view.layer.addSublayer(previewLayer)
        } catch {
            print("CameraManager setup error: \(error)")
        }
    }
    
    private func recognizeText(from image: UIImage) {
        textRecognizer.recognizeText(from: image) { recognizedNameID in
            if let text = recognizedNameID {
                self.recognizedNameID?(text)
                print("Recognized Text: \(text)")
            } else {
                print("CameraManager failed recognization")
            }
        }
        capturedIDCard?(image)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
    }
}

extension CameraManager: AVCapturePhotoCaptureDelegate {
    func takePhoto() {
        guard let connection = photoOutput.connection(with: .video), connection.isActive else { return }
        
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        photoOutput.capturePhoto(with: settings, delegate: self)
        isTaken = true
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("CameraManager capture error: \(error)")
            return
        }
        
        guard let data = photo.fileDataRepresentation(), let fullImage = UIImage(data: data) else {
            print("CameraManager failed to get image data")
            return
        }
        
        guard let croppedImage = processCapturedImage(fullImage) else {
            print("CameraManager failed to crop")
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
}

extension CameraManager:AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard !isTaken else { return }

        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let image = CIImage(cvPixelBuffer: imageBuffer)
        if rectangleDetector.detectRectangle(from: image) {
            takePhoto()
        }
    }
}
