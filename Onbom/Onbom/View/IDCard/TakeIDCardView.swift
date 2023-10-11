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
    @EnvironmentObject var applicationViewModel: ApplicationViewModel

    let guidelineRect = CGRect(x: 0, y: 0.25, width: 1, height: 0.35)
    var body: some View {
        NavigationStack {
            ZStack {
                CameraViewer(capturedImage: { image in
                    applicationViewModel.image = image
                }, recognizedID: { id in
                    applicationViewModel.agentID = id
                })
                    .edgesIgnoringSafeArea(.all)
                
                Color.black.opacity(backgroundOpacity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    RoundedRectangle(cornerRadius: frameRadius)
                        .aspectRatio(cardRatio, contentMode: .fit)
                        .blendMode(.destinationOut)
                        .padding()
                    
                    NavigationLink(destination: ConfirmIDCardView()) {
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
