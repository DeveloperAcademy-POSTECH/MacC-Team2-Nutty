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
    private let textRecognizer = TextRecognizer()
    private var isTaken = false
    var capturedIDCard: ((UIImage) -> Void)?
    var recognizedID: ((String) -> Void)?
    var recognizedName: ((String) -> Void)?

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
                self.recognizedID?(text)
//                self.recognizedName?(text.name)
                print("Recognized Text: \(text)")
            } else {
                print("CameraManager failed recognization")
            }
        }
        capturedIDCard?(image)
    }
    
    private func cropImage(from originalImage: CIImage) -> UIImage? {
        let imageSize = originalImage.extent.size
        //720, 110, (imageSize.height * 0.5), (imageSize.width * 0.45) 기기대응을 위해 수식 만들기
        print(imageSize) //iPhone14: (1920.0, 1080.0)
        let cropRect = CGRect(
            x: 720,
            y: 110,
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
        
        guard let croppedImage = processCropImage(fullImage) else {
            print("CameraManager failed to crop")
            return
        }
//        capturedIDCard?(croppedImage)
        recognizeText(from: croppedImage)
    }
    
    private func processCropImage(_ image: UIImage) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        return cropImage(from: ciImage)
    }
}
