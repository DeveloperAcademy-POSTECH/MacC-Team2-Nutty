//
//  DocumentCameraViewer.swift
//  Onbom
//
//  Created by Junyoo on 2023/09/28.
//

import SwiftUI

struct DocumentCameraViewer: UIViewControllerRepresentable {
    let cameraManager = CameraManager()
    var capturedImage: ((UIImage) -> Void)?
    var recognizedText: ((String) -> Void)?
    
    func makeUIViewController(context: Context) -> CameraManager {
        return cameraManager
    }

    func updateUIViewController(_ uiViewController: CameraManager, context: Context) { }
}
