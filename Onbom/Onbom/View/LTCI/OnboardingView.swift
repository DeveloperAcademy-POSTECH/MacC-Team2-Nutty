//
//  OnboardingView.swift
//  Onbom
//
//  Created by moon on 10/23/23.
//

import SwiftUI

struct OnboardingView: View {
    @State private var selectedTab: Int = 0
    @Binding var isOnboarding: Bool
    
    var body: some View {
        TabView(selection: $selectedTab){
            VStack(alignment: .center){
                Text("3분이면 장기요양등급\n심사서류 작성 완료!")
                    .H1()
                    .foregroundColor(.G6)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 12)
                Text("장기요양보험을 집에서 편하게 신청할 수 있어요")
                    .Cap2()
                    .foregroundColor(.G4)
                    .padding(.bottom, 48)
                Image("OnboardingView_1")
            }
            .tag(0)
            VStack(alignment: .center){
                Text("요양보호사,복지용구 정보\n편하게 받아보세요")
                    .H1()
                    .foregroundColor(.G6)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 12)
                Text("장기요양등급에 따라 맞춤 정보를 알려드려요")
                    .Cap2()
                    .foregroundColor(.G4)
                    .padding(.bottom, 48)
                Image("OnboardingView_2")
            }
            .tag(1)
            
            VStack(alignment: .center){
                Text("어르신 돌봄에 도움되는\n꿀팁 알려드려요")
                    .H1()
                    .foregroundColor(.G6)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 12)
                Text("치매 어르신 돌봄 첫걸음, 손쉽게 시작해요")
                    .Cap2()
                    .foregroundColor(.G4)
                    .padding(.bottom, 48)
                Image("OnboardingView_3")
            }
            .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .overlay(
            HStack(spacing: 4){
                ForEach(0..<3) { index in
                    Capsule()
                        .fill(index == selectedTab ? Color.Green4 : Color.G3)
                        .frame(width: index == selectedTab ? 20 : 8, height: 8)
                }
            },
            alignment: .bottom
        )
        Spacer()
        
        CTAButton.CustomButtonView(style: .main) {
            onClickButton()
        } label: {
            Text(selectedTab == 2 ? "시작하기" : "다음")
        }
        .frame(maxWidth: .infinity)
        .padding([.top, .leading, .trailing], 20)
    }
    
    func onClickButton() {
        if(selectedTab == 2) {
            isOnboarding = false
            return
        }
        withAnimation {
            selectedTab = selectedTab + 1
        }
    }
}

