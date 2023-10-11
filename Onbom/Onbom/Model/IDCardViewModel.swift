//
//  IDCardViewModel.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/09.
//

import SwiftUI

class IDCardViewModel: ObservableObject {
    @Published var idCard = IDCard()
    let cameraManager = CameraManager()

    init() {
        bindToCameraManager()
    }
    
    private func bindToCameraManager() {
        cameraManager.capturedIDCard = { [weak self] image in
            self?.idCard.image = image
        }
        cameraManager.recognizedName = { [weak self] name in
            self?.idCard.name = name
        }
        cameraManager.recognizedID = { [weak self] id in
            self?.idCard.name = id
        }

    }
}

struct IDCard {
    var image: UIImage?
    var name: String = ""
    var idNumber: String = ""
}
