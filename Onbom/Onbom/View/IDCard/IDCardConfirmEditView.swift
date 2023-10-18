//
//  ConfirmIDCardView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/01.
//

import SwiftUI

struct IDCardConfirmEditView: View {
    @Binding var image: UIImage?
    @State private var frontIDNumber = ""
    @State private var backIDNumber = ""
    @EnvironmentObject var patient: Patient
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel

    var body: some View {
            VStack {
                HStack {
                    Text("신분증 정보를 확인해 주세요")
                        .H2()
                        .foregroundColor(.B)
                    Spacer()
                }
                .padding()
                
                Text("신분증 정보는 저장되지 않고, 신청 즉시 파기돼요")
                    .padding(.bottom)
                    .padding(.bottom)

                IDNumberInputField(frontNumber: $frontIDNumber, backNumber: $backIDNumber)
                
                Spacer()

                Rectangle()
                    .foregroundColor(.gray)
                    .overlay {
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        } else {
                            Text("사진없음")
                        }
                    }
                    .padding()

                //CTA Button
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("재촬영")
                    }
                    
                    Spacer()
                    
                    Button {
                        //path append
                        patient.combineID(frontID: frontIDNumber, backID: backIDNumber)
                        print(patient.id)
                    } label: {
                        Text("다음")
                    }
                }
                .padding()
            }
        .navigationBarBackButton()
    }
}

struct IDCardConfirmEditView_Previews: PreviewProvider {
    static var previews: some View {
        IDCardConfirmEditView(image: Binding.constant(UIImage()))
            .environmentObject(Patient())
    }
}

