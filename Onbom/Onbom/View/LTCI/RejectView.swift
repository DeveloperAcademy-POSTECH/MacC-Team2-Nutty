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
        VStack(spacing: 0) {
            Text("지금은 어르신의 등급심사가 어려워요")
                .foregroundColor(Color.B)
                .H1()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 21)
            VStack {
                Text("최근 입원/수술 이력이 있으면 등급심사를 할 수 없어요")
                    .foregroundColor(Color.G5)
                    .Cap3()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                Text("장기요양등급을 신청할 수 있을 때까지 기다리는 동안\n온봄이 몇 가지 서비스를 추천해 드릴게요")
                    .foregroundColor(Color.G5)
                    .Cap3()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 70)
            }
            .frame(maxWidth:. infinity, minHeight: 75)
                        
            Image("RejectView")
//                .border(.yellow)
            Spacer()
            CTAButton.CustomButtonView(
                style: .primary(isDisabled: false))
            {
                navigation.popToRoot()
            } label: {
                Text("한 달 후 다시 알림 받기")
            }
            .padding(.top, 50)
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
