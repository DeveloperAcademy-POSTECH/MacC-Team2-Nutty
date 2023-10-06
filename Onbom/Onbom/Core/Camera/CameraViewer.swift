//
//  CameraViewer.swift
//  Onbom
//
//  Created by Junyoo on 2023/09/28.
//

import SwiftUI

struct CameraViewer: UIViewControllerRepresentable {
    let cameraManager = CameraManager()
    
    func makeUIViewController(context: Context) -> CameraManager {
        return cameraManager
    }

    func updateUIViewController(_ uiViewController: CameraManager, context: Context) { }
}
