//
//  MediHistoryView.swift
//  Onbom
//
//  Created by moon on 10/8/23.
//

import SwiftUI

struct MediHistoryView: View {
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Text("김순옥님께서 3개월 내\n입원·수술 이력이 있으신가요?")
                .foregroundColor(Color.B)
                .H2()
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Rectangle()
                .fill(Color.G2)
                .frame(maxHeight: 270)
                .padding(30)
            Spacer()
            
            CTAButton.CustomButtonView(
                style: .main)
            {
                homeNavigation.navigate(.MediConditionView)
            } label: {
                   Text("아니요, 없어요")
            }
            .padding(.bottom, 10)
            
            CTAButton.CustomButtonView(
                style: .secondary(isDisabled: false))
            {
                homeNavigation.navigate(.RejectView)
            } label: {
                   Text("입원 또는 수술 이력이 있어요")
            }
            .padding(.bottom, 10)
            

        }
        .navigationBarBackButton()
        .padding(20)
    }
}

