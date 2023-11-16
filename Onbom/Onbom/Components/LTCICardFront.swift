//
//  LTCICardFront.swift
//  Onbom
//
//  Created by moon on 11/16/23.
//

import SwiftUI

struct LTCICardFront: View {
    @EnvironmentObject var navigation: NavigationManager
    @EnvironmentObject var mainViewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Text("집에서 간편하게\n장기요양등급 신청해 보세요")
                .T1()
                .foregroundColor(Color.B)
                .lineSpacing(4)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
                .frame(maxWidth: .infinity)
            Image("MainView")
            CTAButton.CustomButtonView(
                style: .main)
            {
                mainViewModel.state = .before
                navigation.navigate(.DescriptionView)
            } label: {
                Text("지금 바로 신청하기")
            }
            .padding([.horizontal, .bottom], 20)
        }
        .background(RoundedRectangle(cornerRadius: 20).fill(.white)
            .shadow(color: .black.opacity(0.05), radius: 5))
        .padding(20)
    }
}

#Preview {
    LTCICardFront()
}
