//
//  IDCardOCRView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/01.
//

import SwiftUI

struct IDCardOCRView: View {
    let backgroundOpacity = 0.8
    let cameraViewer = CameraViewer()
    @State private var captureImage: UIImage? = nil
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    
    var body: some View {
            ZStack {
                cameraViewer
                    .edgesIgnoringSafeArea(.all)
                
                Color.black.opacity(backgroundOpacity)
                    .edgesIgnoringSafeArea(.all)
                
                CaptureIDCardVIew()
                .onAppear {
                    cameraViewer.cameraManager.capturedImage = { image in
                        captureImage = image
                    }
                }
                NavigationLink(destination: IDCardConfirmEditView(image: $captureImage)) {
                    Text("다음")
                }
            }
        .navigationBarBackButton(color: .white)
    }
}

struct CaptureIDCardVIew: View {
    let frameRadius = 14.0
    let cardRatio = 1.6
    
    var body: some View {
        VStack {
            Spacer()
            
            RoundedRectangle(cornerRadius: frameRadius)
                .aspectRatio(cardRatio, contentMode: .fit)
                .blendMode(.destinationOut)
                .overlay {
                    RoundedRectangle(cornerRadius: frameRadius)
                        .stroke(.white, lineWidth: 2)
                }
                .padding()
            Text("가이드라인에 신분증을 맞춰주세요")
                .T5()
                .foregroundColor(.PB4)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 24)
                        .foregroundColor(.white)
                }
            
            Spacer()
            
            HStack {
                VStack {
                    Image("IDCard")
                        .padding()
                    Text("어두운 배경에\n신분증을 놓아 주세요")
                        .T5()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                Divider()
                    .background(Color.G5)
                    .frame(maxHeight: 100)
                    .padding(.top)
                    .padding()
                VStack {
                    Image("Light")
                        .padding()
                    Text("빛이 반사되지 않도록\n방향을 조절해 주세요.")
                        .T5()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
            }
            
            Spacer()
        }
    }
}

struct IDCardOCRView_Previews: PreviewProvider {
    static var previews: some View {
        IDCardOCRView()
    }
}
