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
        //TODO: - Gradient 배경 빠져 있음
        VStack {
            Text("김순옥님께서 3개월 내\n입원 또는 수술 이력이 있으신가요?")
                .foregroundColor(Color.B)
                .H2()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 89)
            Image("MediHistoryImage")
                .padding(.bottom, 104)
            VStack(spacing: 10) {
                CTAButton.CustomButtonView(
                    style: .main)
                {
                    homeNavigation.navigate(.MediConditionView)
                } label: {
                    Text("없어요")
                }
                CTAButton.CustomButtonView(
                    style: .secondary)
                {
                    homeNavigation.navigate(.RejectView)
                } label: {
                    Text("입원 또는 수술 이력이 있어요")
                }
            }
        }
        .padding([.top, .leading, .trailing], 20)
        .navigationBarBackButton()
    }
}

struct MediHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        MediHistoryView()
    }
}
