//
//  DescriptionView.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/23.
//

import SwiftUI

struct DescriptionView: View {
    @EnvironmentObject var navigation: NavigationManager
    var body: some View {
        VStack {
            Text("치매돌봄 혜택의 첫걸음,\n장기요양등급 신청 3분만에")
                .H1()
                .foregroundColor(Color.G6)
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            Text("기존의 불편하고 어려웠던 등급 신청 과정을\n간단하게 처리할 수 있도록 해드려요")
                .Cap2()
                .foregroundColor(Color.G4)
                .multilineTextAlignment(.center)
                .padding(.bottom, 30)
            Image("DescriptionView")
            Spacer()
            VStack(spacing: 10) {
                CTAButton.CustomButtonView(
                    style: .primary(isDisabled: false))
                {
                    navigation.navigate(.ApplyTypeView)
                } label: {
                    Text("신청하기")
                }
            }
        }
        .padding(.top, 75)
        .padding(.horizontal, 20)
        .navigationBarBackButton()
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView()
    }
}
