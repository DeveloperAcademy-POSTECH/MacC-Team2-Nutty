//
//  RejectView.swift
//  Onbom
//
//  Created by moon on 10/9/23.
//

import SwiftUI

struct RejectView: View {
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel

    
    var body: some View {
        VStack(spacing: 0) {
            Text("김순옥님,\n지금은 등급심사가 어려워요")
                .foregroundColor(Color.B)
                .H2()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("최근 입원/수술 이력이 있으면 등급심사를 할 수 없어요")
                .foregroundColor(Color.G5)
                .Cap2()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 20)
            Text("장기요양등급을 신청할 수 있을 때까지 기다리는 동안\n온봄이 몇 가지 서비스를 추천해 드릴게요")
                .foregroundColor(Color.G5)
                .Cap2()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            Rectangle()
                .fill(Color.G2)
                .frame(maxHeight: 270)
                .padding(30)
            Spacer()
            
            Button {
                homeNavigation.popToRoot()
            } label: {
                Text("메인화면으로 가기")
                    .foregroundColor(Color.white)
                    .B1()
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
            }
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.PB4))
            .padding(.bottom, 10)
        }
        .padding(20)
    }
}

