//
//  RejectView.swift
//  Onbom
//
//  Created by moon on 10/9/23.
//

import SwiftUI

struct RejectView: View {
    @EnvironmentObject var navigation: NavigationManager
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("지금은 어르신의\n등급심사가 어려워요")
                    .foregroundColor(Color.B)
                    .H1()
                Text("입원이나 수술 등으로 거동이 잠시 불편해진 경우\n최소 3개월 이후 등급심사를 권하고 있어요")
                    .foregroundColor(Color.G5)
                    .B3()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            Image("RejectView")
            Spacer()
            
            VStack(spacing: 10) {
                CTAButton.CustomButtonView(
                    style: .primary(isDisabled: false))
                {
                    navigation.popToRoot()
                } label: {
                    Text("한 달 후 다시 알림 받기")
                }
                CTAButton.CustomButtonView(
                    style: .secondary)
                {
                    navigation.navigate(.MediConditionView)
                } label: {
                    Text("그래도 신청할래요")
                }
            }
        }
        .padding([.top, .leading, .trailing], 20)
        .navigationBarBackButton()
    }
}

struct RejectView_Previews: PreviewProvider {
    static var previews: some View {
        RejectView()
    }
}
