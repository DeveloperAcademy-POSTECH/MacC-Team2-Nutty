//
//  IDCardConfirmEditView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/15.
//

import SwiftUI

struct IDCardConfirmEditView: View {
    @State private var frontIDNumber = ""
    @State private var backIDNumber = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var agent: Agent
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    
    var isAddressFilled: Bool {
        !frontIDNumber.isEmpty && !backIDNumber.isEmpty
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("신분증 정보를 확인해 주세요")
                    .H2()
                    .foregroundColor(.B)
                Spacer()
            }
            .padding()
            
            Alert(image: "security",
                  label: "신분증 정보는 저장되지 않고, 신청 즉시 파기돼요")
            .padding(.horizontal)
            .padding(.bottom)
            
            Rectangle()
                .foregroundColor(.white)
                .overlay {
                    Image(uiImage: agent.idCardImage)
                        .resizable()
                        .scaledToFit()
                }
                .padding()
                .frame(height: 240)
            
            IDNumberInputField(frontNumber: $frontIDNumber, backNumber: $backIDNumber)
                .onAppear {
                    let splittedID = agent.splitID()
                    frontIDNumber = splittedID.frontID
                    backIDNumber = splittedID.backID
                }
            
            Spacer()
            
            HStack {
                CTAButton.CustomButtonView(style: .secondary) {
                    dismiss()
                } label: {
                    Text("재촬영")
                }
                .frame(width: 100)
                
                CTAButton.CustomButtonView(style: .primary(isDisabled: !isAddressFilled)) {
                    agent.combineID(frontID: frontIDNumber, backID: backIDNumber)
                    homeNavigation.navigate(.AddressFormView_Agent)
                } label: {
                    Text("다음")
                }
                .frame(maxWidth: .infinity)
            }
            .padding([.top, .leading, .trailing], 20)
        }
        .navigationBarBackButton()
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct IDCardConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        IDCardConfirmEditView()
            .environmentObject(Agent())
    }
}

