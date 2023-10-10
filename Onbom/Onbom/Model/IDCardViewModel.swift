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
        
        cameraManager.recognizedNameID = { [weak self] namdID in
            self?.idCard.nameID = namdID
        }
    }
}

struct IDCard {
    var image: UIImage?
    var nameID = NameID()
}

struct NameID {
    var name: String = ""
    var idNumber: String = ""
}
