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
        ZStack {
            VStack {
                Color.W
                Color.G2
            }
            
            ScrollView {
                Image("DescriptionView")
                    .resizable()
                    .scaledToFit()
            }
            .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                LinearGradient(
                    stops: [
                        .init(color: .TPW, location : 0),
                        .init(color: .W, location : 0.48)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: 104)
                .overlay {
                    VStack {
                        Spacer()
                        CTAButton.CustomButtonView(
                            style: .primary(isDisabled: false))
                        {
                            navigation.navigate(.ApplyTypeView)
                        } label: {
                            Text("바로 신청하기")
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .navigationBarBackButton()
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView()
    }
}
