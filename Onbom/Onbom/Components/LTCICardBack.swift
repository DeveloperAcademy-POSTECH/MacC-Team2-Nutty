//
//  LTCICardBack.swift
//  Onbom
//
//  Created by moon on 11/16/23.
//

import SwiftUI

struct LTCICardBack: View {
    @EnvironmentObject var navigation: NavigationManager
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center){
                Text("장기요양등급 신청 현황")
                    .T2()
                    .foregroundColor(.B)
                Spacer()
                Image(systemName: "chevron.forward")
                    .foregroundColor(Color.G4)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.top, 24)
            .padding(.bottom, 12)
            
            HStack{
                Text("신규 신청")
                    .Cap6()
                    .foregroundStyle(Color.Green4)
                    .font(.system(size: 11, weight: .regular))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 6)
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color.Green2))
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 80)
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
                    Capsule()
                        .fill(Color.G2)
                        .frame(height: 6.5)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            Image("progress_percent").offset(y: -14)
                            , alignment: .bottom
                        )
                    Capsule()
                        .fill(Color.Green4)
                        .frame(height: 6.5)
                        .frame(maxWidth: geometry.size.width / 2)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 7)
            
            HStack {
                Text("서류 전송")
                    .Cap6()
                    .foregroundColor(.G4)
                Spacer()
                Text("국민건강보험공단 확인중")
                    .Cap6()
                    .foregroundColor(.Green4)
                Spacer()
                Text("방문조사")
                    .Cap6()
                    .foregroundColor(.G4)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
            
            Text("국민건강보험공단에서 서류를 접수하면")
                .Cap3()
                .foregroundColor(.G5)
                .multilineTextAlignment(.center)
            HStack(alignment: .center, spacing: 0){
                Text("어르신이 계시는 주소로 방문조사")
                    .B2()
                    .foregroundColor(.B)
                Text("가 진행돼요")
                    .Cap3()
                    .foregroundColor(.G5)
            }
            .padding(.bottom, 24)
        }
        .homeViewShadow()
        .padding(20)
        .onTapGesture {
            navigation.navigate(.ApplyHistoryView)
        }
    
    }
}

#Preview {
    LTCICardBack()
}
