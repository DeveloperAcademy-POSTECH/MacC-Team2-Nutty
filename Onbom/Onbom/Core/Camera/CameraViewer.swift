//
//  CameraViewer.swift
//  Onbom
//
//  Created by Junyoo on 2023/09/28.
//

import SwiftUI

struct CameraViewer: UIViewControllerRepresentable {
    let cameraManager = CameraManager()
    var capturedImage: ((UIImage) -> Void)?
    var recognizedID: ((String) -> Void)?

    func makeUIViewController(context: Context) -> CameraManager {
        cameraManager.capturedIDCard = capturedImage
        cameraManager.recognizedID = recognizedID
        return cameraManager
    }

    func updateUIViewController(_ uiViewController: CameraManager, context: Context) { }
}
