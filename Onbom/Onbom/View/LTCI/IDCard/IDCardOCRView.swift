//
//  IDCardOCRView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/01.
//

import SwiftUI

struct IDCardOCRView: View {
    let backgroundOpacity = 0.8
    let cameraViewer = IDCardCameraViewer()
    @Binding var presentIDCardOCR: Bool
    @EnvironmentObject var agent: Agent
    
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
#if DEBUG
                    Button("완료") {
                        onFinishCapture()
                    }
#endif
                }
                Spacer()
            }
        }
        .onAppear {
            cameraViewer.cameraManager.capturedIDCard = { image in
                agent.idCardImage = image
            }
            cameraViewer.cameraManager.recognizedID = { idNumber in
                agent.id = idNumber
            }
        }
        .onChange(of: agent.idCardImage) { _ in
            onFinishCapture()
        }
    }
}

fileprivate struct IDCardGuideLineView: View {
    let cardRatio = 1.6
    let backgroundOpacity = 0.6
    @State private var presentCameraGuideSheet = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                
                Text("가이드라인에 신분증을 맞춰주세요")
                    .T4()
                    .foregroundColor(.Green4)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
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
                    .padding(.vertical, 24)
                
                Button {
                    presentCameraGuideSheet = true
                } label: {
                    HStack {
                        Text("신분증 촬영 방법")
                            .B2()
                            .foregroundColor(.G4)
                        Image("chevronRight")
                            .foregroundColor(.G5)
                    }
                }
                
                Spacer()
                
            }
            if presentCameraGuideSheet {
                Color.black.opacity(backgroundOpacity)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .sheet(isPresented: $presentCameraGuideSheet) {
            IDCardOCRSheet(presentCameraGuideSheet: $presentCameraGuideSheet)
                .presentationDetents([.fraction(0.47)])
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
                    .padding(.leading, 20)
                    .padding(.top, 34)
                
                Spacer()
            }
            
            ForEach(0..<sheetString.count, id: \.self) { index in
                HStack(alignment: .center) {
                    Text("\(index + 1)")
                        .Cap3()
                        .foregroundColor(.Green4)
                        .padding(8)
                        .background(
                            Circle()
                                .fill(Color.Green2)
                                .frame(width: 21, height: 21)
                        )

                    Text(sheetString[index])
                        .B3()
                        .foregroundColor(.G5)
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.top, 8)
            }
            
            CTAButton.CustomButtonView(style: .primary(isDisabled: false)) {
                presentCameraGuideSheet = false
            } label: {
                Text("확인")
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
        }
    }
}

struct IDCardOCRView_Previews: PreviewProvider {
    static var previews: some View {
        IDCardOCRView(presentIDCardOCR: .constant(false), onFinishCapture: {})
            .environmentObject(Agent())
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
    }
}
