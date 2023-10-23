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
    @Binding var presentIDCardOCR: Bool
    @State private var captureImage: UIImage? = nil
    @State private var temp: Bool = false
    @EnvironmentObject var agent: Agent
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    
    var onFinishCapture: () -> Void

    var body: some View {
            ZStack {
                cameraViewer
                    .edgesIgnoringSafeArea(.all)
                
                Color.black.opacity(backgroundOpacity)
                    .edgesIgnoringSafeArea(.all)
                
                IDCardGuideLineView()
                
                VStack {
                    HStack {
                        Button {
                            presentIDCardOCR = false
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 24))
                                .padding()
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    Spacer()
                    Button {
                        
                        cameraViewer.cameraManager.takePhoto()
                        cameraViewer.cameraManager.capturedIDCard = { image in
                            agent.idCardImage = image
                        }
                        cameraViewer.cameraManager.recognizedID = { idNumber in
                            agent.id = idNumber
                        }
                        
                        onFinishCapture()
                        
                    } label: {
                        Circle()
                            .frame(width: 56, height: 56)
                            .foregroundColor(.white)
                            .padding(7)
                            .overlay {
                                Circle()
                                    .strokeBorder(.white, lineWidth: 3)
                            }
                    }
                    .padding(.bottom)
                    .padding(.bottom)
                }
            }
        
    }
}

fileprivate struct IDCardGuideLineView: View {
    let cardRatio = 1.6
    @State private var presentCameraGuideSheet = false

    var body: some View {
        VStack {
            Spacer()
            
            Text("가이드라인에 신분증을 맞춰주세요")
                .T5()
                .foregroundColor(.PB4)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 24)
                        .foregroundColor(.white)
                }
            
            Rectangle()
                .aspectRatio(cardRatio, contentMode: .fit)
                .blendMode(.destinationOut)
                .overlay {
                    Rectangle()
                        .strokeBorder(.white, lineWidth: 5)
                }
                .padding(.vertical)
                .padding(.bottom)
            
            Button {
                presentCameraGuideSheet = true
            } label: {
                HStack {
                    Text("신분증 촬영 방법")
                        .B2()
                        .foregroundColor(.G4)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.G5)
                }
                .padding()
            }
            
            Spacer()
            
        }
        .sheet(isPresented: $presentCameraGuideSheet) {
            IDCardOCRSheet(presentCameraGuideSheet: $presentCameraGuideSheet)
                .presentationDetents([.fraction(0.5)])
                .presentationCornerRadius(12)
        }
    }
}

fileprivate struct IDCardOCRSheet: View {
    
    let sheetString = ["인쇄물이 아닌 실제 신분증을 촬영해 주세요",
                       "얼굴 사진과 글자가 모두 잘 보여야 해요",
                       "평평한 바닥에서 신분증을 촬영해 주세요",
                       "지갑, 케이스에 있다면 꺼내서 촬영해 주세요"]
    @Binding var presentCameraGuideSheet: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("신분증 촬영 방법")
                    .T1()
                    .foregroundColor(.G6)
                    .padding(.leading)
                    .padding(.top)
                Spacer()
            }
                        
            ForEach(0..<sheetString.count, id: \.self) { index in
                HStack {
                    Text("\(index + 1)")
                        .Label()
                        .foregroundColor(.PB4)
                        .padding(8)
                        .background {
                            Circle().fill(Color.PB2)
                        }
                    Text(sheetString[index])
                    Spacer()
                }
                .padding(.leading)
                .padding(.top, 8)
            }
                        
            //CTA Button
            Button {
                presentCameraGuideSheet = false
            } label: {
                Text("확인")
                    .foregroundColor(Color.white)
                    .B1()
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
            }
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.PB4))
            .padding()
        }
    }
}

struct IDCardOCRView_Previews: PreviewProvider {
    static var previews: some View {
        IDCardOCRView(presentIDCardOCR: .constant(false), onFinishCapture: {})
    }
}
