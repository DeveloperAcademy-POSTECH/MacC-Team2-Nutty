//
//  TakeIDCardView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/01.
//

import SwiftUI

struct TakeIDCardView: View {
    let backgroundOpacity = 0.7
    let frameRadius = 16.0
    let cardRatio = 1.6
    let cameraViewer = CameraViewer()
    @State private var captureImage: UIImage? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                cameraViewer
                    .edgesIgnoringSafeArea(.all)
                
                Color.black.opacity(backgroundOpacity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    RoundedRectangle(cornerRadius: frameRadius)
                        .aspectRatio(cardRatio, contentMode: .fit)
                        .blendMode(.destinationOut)
                        .padding()
                    
                    Button {
                        cameraViewer.cameraManager.takePhoto()
                    } label: {
                        Image(systemName: "circle.circle")
                            .font(.largeTitle)
                    }
                    .onAppear {
                        cameraViewer.cameraManager.capturedImage = { image in
                            captureImage = image
                        }
                    }
                    NavigationLink(destination: ConfirmIDCardView(image: $captureImage)) {
                        Text("다음")
                    }
                    .padding()
                }
            }
        }
    }
}

struct TakeIDCardView_Previews: PreviewProvider {
    static var previews: some View {
        TakeIDCardView()
    }
}
