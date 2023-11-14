//
//  DocumentDescriptionView.swift
//  Onbom
//
//  Created by Junyoo on 11/13/23.
//

import SwiftUI

struct DocumentDescriptionView: View {
    @State private var name = ""
    @State private var presentDocumentCamera = false
    @EnvironmentObject var patient: Patient
    @EnvironmentObject var navigation: NavigationManager
    
    var body: some View {
        VStack {
            HStack {
                Text("\(name)님의 장기요양인정서를\n촬영할 수 있게 준비해 주세요")
                    .H1()
                    .foregroundColor(.B)
                    .padding(.bottom, 20)
                Spacer()
            }
            HStack {
                Text("등급 인정 시에 받았던 서류 중 ‘장기요양인정서'가 적혀있는 서류가 필요해요")
                    .Cap3()
                    .foregroundColor(.G5)
                Spacer()
            }
            
            Spacer()
            
            Image("DescriptionView")
            
            Spacer()
            
            CTAButton.CustomButtonView(style: .primary(isDisabled: false)) {
                presentDocumentCamera = true
            } label: {
                Text("다음")
            }
        }
        .padding([.horizontal, .top], 20)
        .fullScreenCover(isPresented: $presentDocumentCamera) {
            DocumentCameraView(presentCamera: $presentDocumentCamera,
                               onFinishCapture: onFinishCapture)
        }
        .navigationBarBackButton()
        .onAppear {
            name = patient.name
        }
    }
    
    func onFinishCapture() {
        print("onfinished")
        presentDocumentCamera = false
        navigation.navigate(.DocumentConfirmEditView)
    }
}

#Preview {
    DocumentDescriptionView()
        .environmentObject(mockPatient)
}
