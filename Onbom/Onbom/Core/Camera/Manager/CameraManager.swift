//
//  CameraManager.swift
//  Onbom
//
//  Created by Junyoo on 2023/09/28.
//

import UIKit
import AVFoundation

class CameraManager: UIViewController, AVCapturePhotoCaptureDelegate {
    var captureSession = AVCaptureSession()
    var photoOutput = AVCapturePhotoOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    var isTaken = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    // TODO: 카메라권한이 없으면 분기처리

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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
    }
    
    func setupCamera() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            captureSession.addOutput(photoOutput)

            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)
        } catch {
            print("CameraManager setup error: \(error)")
        }
    }

    func takePhoto() {
        if !isTaken {
            let settings = AVCapturePhotoSettings()
            photoOutput.capturePhoto(with: settings, delegate: self)
            isTaken = true
        }
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("CameraManager capture error: \(error)")
            return
        }
    }
}
