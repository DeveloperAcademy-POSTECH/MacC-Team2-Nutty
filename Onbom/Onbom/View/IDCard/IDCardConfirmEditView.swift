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

    var body: some View {
        VStack {
            HStack {
                Text("신분증 정보를 확인해 주세요")
                    .H2()
                    .foregroundColor(.B)
                Spacer()
            }
            .padding()
            
            HStack(spacing: 4) {
                Image("security")
                    .padding(.leading)
                Text("신분증 정보는 저장되지 않고, 신청 즉시 파기돼요")
                    .foregroundColor(Color.G6)
                    .Cap4()
                    .padding(.vertical)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.PB1))
            .padding(20)
            
            Rectangle()
                .foregroundColor(.gray)
                .overlay {
                    Image(uiImage: agent.idCardImage)
                        .resizable()
                        .scaledToFit()
                }
                .padding()
                .frame(height: 250)
            
            IDNumberInputField(frontNumber: $frontIDNumber, backNumber: $backIDNumber)
                .onAppear {
                    frontIDNumber = agent.id
                    backIDNumber = agent.id
                }
            
            Spacer()
            
            HStack {
                CTAButton.CustomButtonView(style: .secondary(isDisabled: false)) {
                    dismiss()
                } label: {
                    Text("재촬영")
                }
                .frame(width: 100)
                CTAButton.CustomButtonView(style: .main) {
                    agent.combineID(frontID: frontIDNumber, backID: backIDNumber)
                    homeNavigation.navigate(.AddressFormView_Agent)
                } label: {
                    Text("다음")
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
        }
        .navigationBarBackButton()
    }
}

struct IDCardConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        IDCardConfirmEditView()
            .environmentObject(Agent())
    }
}

