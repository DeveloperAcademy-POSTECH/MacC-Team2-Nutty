//
//  CameraViewer.swift
//  Onbom
//
//  Created by Junyoo on 2023/09/28.
//

import SwiftUI

struct CameraViewer: UIViewControllerRepresentable {
    @ObservedObject var viewModel: IDCardViewModel
    
    func makeUIViewController(context: Context) -> CameraManager {
        return viewModel.cameraManager
    }

    func updateUIViewController(_ uiViewController: CameraManager, context: Context) { }
}

