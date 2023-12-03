//
//  HomeNavigationBar.swift
//  Onbom
//
//  Created by moon on 11/16/23.
//

import SwiftUI

struct HomeNavigationBar: View {
    let pdfManager: PDFManager = .shared
    @EnvironmentObject var navigation: NavigationManager
    @EnvironmentObject var mainViewModel: MainViewModel
    @EnvironmentObject var patient: Patient
    @EnvironmentObject var agent: Agent
    
    @Binding var scrollToTop: Bool
    
    let transparant: Bool
    
    init(transparant: Bool, scrollToTop: Binding<Bool> = .constant(false)) {
        self.transparant = transparant
        _scrollToTop = scrollToTop
    }
    
    var body: some View {
        CustomNavigationBar {
            HStack(alignment: .center, spacing: 8) {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 31)
                    .padding(.top, 4)
                    .padding(.leading, 20)
                Text("온봄")
                    .foregroundColor(Color.Green4)
                    .font(.custom("Dongle-Bold", size: 39))
            }
            .padding(.top, 2)
            .opacity(transparant ? 0.0000001 : 1)
            .onTapGesture(count: 3) { onReset() }
        } trailing: {
            Button {
                navigation.navigate(.NotificationView)
            } label : {
                Image("notification")
            }
            .frame(width: 34, height: 34)
            .padding(.trailing, 20)
            .padding(.top, 6)
            .disabled(transparant)
        }
        .padding(.bottom, 6)
        .padding(.top, 4)
    
    }
    private func onReset() {
        mainViewModel.state = .before
        pdfManager.PDFDatas.removeAll()
        patient.reset()
        agent.reset()
        scrollToTop.toggle()
        navigation.navigate(.OnboardingView)
    }
}

#Preview {
    HomeNavigationBar(transparant: false)
}
