//
//  SubmitView.swift
//  Onbom
//
//  Created by 금가경 on 2023/10/23.
//

import SwiftUI

struct SubmitView: View {
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    @EnvironmentObject var patient: Patient
    @EnvironmentObject var agent: Agent
    @EnvironmentObject var pdfManager: PDFManager
    @State private var isloadingViewPresented = true
    
    var body: some View {
        if isloadingViewPresented {
            SubmitLoadingView()
                .onAppear {
                    showLoadingView()
                }
        } else {
            VStack {
                VStack(spacing: 20) {
                    Text("신청 끝!\n약 2주 후 방문 조사가 있어요")
                        .H1()
                        .lineSpacing(10)
                        .foregroundColor(.B)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 40)
                    Text("어르신 방문을 위해 건강보험공단에서 연락을 할 거예요\n등급 산정 과정에서 추가 서류가 필요할 수도 있어요")
                        .Cap3()
                        .lineSpacing(10)
                        .foregroundColor(.G5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxHeight: .infinity, alignment: .topLeading)
                .padding(.bottom, 71)
                Image("SubmitView")
                    .padding(.bottom, 90)
                VStack(spacing: 0) {
                    CTAButton.CustomButtonView(
                        style: .primary(isDisabled: false))
                    {
                        homeNavigation.popToRoot()
                    } label: {
                        Text("신청 완료")
                    }
                    .padding(.bottom, 16)
                    Text("신청에 필요한 수수료는 온봄이 냈어요")
                        .Label()
                        .foregroundColor(.G4)
                }
            }
            .navigationBarBackButtonHidden(true)
            .padding([.top, .leading, .trailing], 20.0)
        }
        
    }
    
    func showLoadingView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isloadingViewPresented = false
        }
    }
}

struct SubmitView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitView()
            .environmentObject(HomeNavigationViewModel())
    }
}
