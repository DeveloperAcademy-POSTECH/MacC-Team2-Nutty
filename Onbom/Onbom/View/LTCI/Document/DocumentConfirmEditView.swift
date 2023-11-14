//
//  DocumentConfirmEditView.swift
//  Onbom
//
//  Created by Junyoo on 11/13/23.
//

import SwiftUI

struct DocumentConfirmEditView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var patient: Patient
    @EnvironmentObject var navigation: NavigationManager
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("서류 사진을 확인해 주세요")
                    .H1()
                    .foregroundColor(.B)
                Spacer()
            }
            .padding(20)
            
            Alert(image: "check",
                  label: "성명과 장기요양등급이 잘 보이는지 확인해 주세요")
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
            
            VStack {
                Image(uiImage: patient.documentImage)
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 33)
                    .padding(.bottom, 21)
                    .padding(.horizontal, 55)
                    .frame(maxWidth: .infinity)
            }
            
            Spacer()
            
            HStack {
                CTAButton.CustomButtonView(style: .secondary) {
                    dismiss()
                } label: {
                    Text("재촬영")
                }
                .frame(width: 100)
                
                CTAButton.CustomButtonView(style: .primary(isDisabled: false)) {
                    navigation.navigate(.DocumentDescriptionView)
                } label: {
                    Text("다음")
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.top, 4)
            .padding(.horizontal, 20)
        }
        .navigationBarBackButton()
    }
}


#Preview {
    DocumentConfirmEditView()
        .environmentObject(mockPatient)
}
