//
//  GuideView.swift
//  Onbom
//
//  Created by moon on 11/16/23.
//

import SwiftUI

struct GuideView: View {
    var body: some View {
        ZStack() {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HomeNavigationBar(transparant: true)
                AdBanner().appear(false)
                LTCICardFront()
                Triangle()
                    .fill(.white)
                    .frame(width: 20, height: 10)
                VStack(alignment: .leading, spacing: 0){
                    Text("온봄이 처음이신가요?")
                        .B1()
                        .foregroundColor(.B)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    HStack(alignment: .center, spacing: 0) {
                        Text("신청하기 버튼을 눌러 ")
                            .Cap4()
                            .foregroundColor(.G6)
                        Text("장기요양등급")
                            .Cap4()
                            .foregroundColor(.Green4)
                        Text("을 받아보세요")
                            .Cap4()
                            .foregroundColor(.G6)
                    }
                    .padding(.leading, 16)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 18)
                .padding(.bottom, 16)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
                .padding(.horizontal, 10)
                
                Spacer()
            }
        }
    }
}

#Preview {
    GuideView()
}
