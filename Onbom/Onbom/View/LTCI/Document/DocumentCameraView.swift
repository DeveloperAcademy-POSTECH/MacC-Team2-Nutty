//
//  DocumentCameraView.swift
//  Onbom
//
//  Created by Junyoo on 11/13/23.
//

import SwiftUI

struct DocumentCameraView: View {
    let backgroundOpacity = 0.8
    let cameraViewer = DocumentCameraViewer()
    @Binding var presentCamera: Bool
    @EnvironmentObject var patient: Patient
    
    var onFinishCapture: () -> Void
    
    var body: some View {
        ZStack {
            cameraViewer
                .edgesIgnoringSafeArea(.all)
            
            Color.black.opacity(backgroundOpacity)
                .edgesIgnoringSafeArea(.all)
            
            DocumentGuideLineView()
            
            VStack {
                HStack {
                    Button {
                        presentCamera = false
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
            cameraViewer.cameraManager.capturedDocument = { image in
                patient.documentImage = image
            }
        }
        .onChange(of: patient.documentImage) { _ in
            onFinishCapture()
        }
    }
}

fileprivate struct DocumentGuideLineView: View {
    let cardRatio = 0.7
    @State private var presentCameraGuideSheet = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                                
                Rectangle()
                    .aspectRatio(cardRatio, contentMode: .fit)
                    .blendMode(.destinationOut)
                    .overlay {
                        Rectangle()
                            .strokeBorder(.white, lineWidth: 5)
                    }
                    .padding(.vertical, 24)

                Text("가이드라인에 서류를 맞춰주세요")
                    .T4()
                    .foregroundColor(.Green4)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .background {
                        RoundedRectangle(cornerRadius: 24)
                            .foregroundColor(.white)
                    }
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    DocumentCameraView(presentCamera: .constant(true), onFinishCapture: {})
        .environmentObject(mockPatient)
}
