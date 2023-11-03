//
//  IDCardCameraViewer.swift
//  Onbom
//
//  Created by Junyoo on 11/1/23.
//

import SwiftUI

struct IDCardCameraViewer: UIViewControllerRepresentable {
    let cameraManager = IDCardCameraManager(rectangleDetector: IDCardDetector(), textRecognizer: IDCardTextRecognizer())
    var capturedImage: ((UIImage) -> Void)?
    var recognizedID: ((String) -> Void)?

    func makeUIViewController(context: Context) -> CameraManager {
        cameraManager.capturedIDCard = capturedImage
        cameraManager.recognizedID = recognizedID
        return cameraManager
    }

    func updateUIViewController(_ uiViewController: CameraManager, context: Context) { }
}
