//
//  DocumentCameraViewer.swift
//  Onbom
//
//  Created by Junyoo on 2023/09/28.
//

import SwiftUI

struct DocumentCameraViewer: UIViewControllerRepresentable {
    let cameraManager = DocumentCameraManager()
    var capturedImage: ((UIImage) -> Void)?
    // TODO: 캡슐화
    
    func makeUIViewController(context: Context) -> CameraManager {
        cameraManager.capturedDocument = capturedImage
        return cameraManager
    }

    func updateUIViewController(_ uiViewController: CameraManager, context: Context) { }
}
