//
//  CameraManager.swift
//  Onbom
//
//  Created by Junyoo on 2023/09/28.
//

import UIKit
import AVFoundation

class CameraManager: UIViewController, AVCapturePhotoCaptureDelegate {
    private let captureSession = AVCaptureSession()
    private var photoOutput = AVCapturePhotoOutput()
    private var previewLayer = AVCaptureVideoPreviewLayer()
    var capturedImage: ((UIImage) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
            if captureSession.canAddInput(input), captureSession.canAddOutput(photoOutput) {
                captureSession.addInput(input)
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
    
    func takePhoto() {
        guard let connection = photoOutput.connection(with: .video), connection.isActive else { return }

        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        photoOutput.capturePhoto(with: settings, delegate: self)
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("CameraManager capture error: \(error)")
        } else if let data = photo.fileDataRepresentation(), let image = UIImage(data: data) {
            capturedImage?(image)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
    }
}
