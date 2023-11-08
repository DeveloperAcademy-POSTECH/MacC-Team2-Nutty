//
//  MediHistoryView.swift
//  Onbom
//
//  Created by moon on 10/8/23.
//

import SwiftUI

struct MediHistoryView: View {
    @EnvironmentObject var navigation: NavigationManager
    
    var body: some View {
        //TODO: - Gradient 배경 빠져 있음
        VStack {
            Text("어르신이 3개월 내 입원 또는\n수술 이력이 있으신가요?")
                .foregroundColor(Color.B)
                .H1()
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Image("MediHistoryImage")
            Spacer()
            VStack(spacing: 10) {
                CTAButton.CustomButtonView(
                    style: .primary(isDisabled: false))
                {
                    navigation.navigate(.MediConditionView)
                } label: {
                    Text("없어요")
                }
                CTAButton.CustomButtonView(
                    style: .secondary)
                {
                    navigation.navigate(.RejectView)
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
