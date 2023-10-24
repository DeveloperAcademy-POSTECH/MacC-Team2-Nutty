//
//  IDCardDescriptionView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/01.
//

import SwiftUI

struct IDCardDescriptionView: View {
    @State private var name = ""
    @State private var presentIDCardOCR = false
    @EnvironmentObject var agent: Agent
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    
    var body: some View {
        VStack {
            Group {
                HStack {
                    Text("\(name)님의 신분증을\n촬영할 수 있도록 준비해 주세요")
                        .H2()
                        .foregroundColor(.B)
                    Spacer()
                }
                .padding()
                HStack {
                    Text("주민등록증 또는 운전면허증을 준비해 주세요.\n사본이나 모니터 촬영, 임시 신분증은 쓸 수 없어요.")
                        .Cap2()
                        .foregroundColor(.G5)
                    Spacer()
                }
                .padding(.leading)
            }
            
            Spacer()
            
            Image("IDCardDescriptionView")
            
            Spacer()
            CTAButton.CustomButtonView(
                style: .primary(isDisabled: false))
            {
                presentIDCardOCR = true
            } label: {
                Text("다음")
            }
//            Button {
//                presentIDCardOCR = true
//            } label: {
//                Text("다음")
//                    .foregroundColor(Color.white)
//                    .B1()
//                    .padding(.vertical, 20)
//                    .frame(maxWidth: .infinity)
//            }
//            .background(RoundedRectangle(cornerRadius: 16).fill(Color.PB4))
            .padding([.top, .leading, .trailing], 20)
        }
        .fullScreenCover(isPresented: $presentIDCardOCR) {
            IDCardOCRView(presentIDCardOCR: $presentIDCardOCR, onFinishCapture: onFinishCapture)
        }
        .navigationBarBackButton()
        .onAppear {
            name = agent.name
        }
    }
    
    func onFinishCapture() {
        presentIDCardOCR = false
        homeNavigation.navigate(.IDCardConfirmEditView)
    }
}

struct IDCardDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        IDCardDescriptionView()
            .environmentObject(Agent())
    }
}
