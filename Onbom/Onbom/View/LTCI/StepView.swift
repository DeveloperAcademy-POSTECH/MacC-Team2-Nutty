//
//  StepView.swift
//  Onbom
//
//  Created by moon on 10/12/23.
//

import SwiftUI

struct StepView: View {
    enum StepViewState {
        case FIRST
        case SECOND
    }
    let state: StepViewState
    @EnvironmentObject var navigation: NavigationManager
    
    init(state: StepViewState) {
        self.state = state
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Image("StepView")
                .resizable()
                .frame(width: 63, height: 63)
                .padding(.bottom, 17)
            Text("장기요양등급 신규 신청을 위해")
                .Cap4()
                .foregroundColor(.G6)
                .padding(.bottom, 10)
            if state == .FIRST {
                Text("신청대상자의 정보부터\n확인할게요")
                    .H1()
                .foregroundColor(.B)
                .padding(.bottom, 32)
            } else {
                Text("대리인 김유진님의 정보를 \n확인할게요")
                    .H1()
                .foregroundColor(.B)
                .padding(.bottom, 32)
            }
            
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                VStack {
                    ZStack {
                        Circle()
                            .frame(width: 31, height: 31)
                            .foregroundColor(state == .FIRST ? Color.Green2 : Color.G2)
                        Text("1")
                            .Label()
                            .foregroundColor(state == .FIRST ? Color.Green4 : Color.G4)
                    }
                    Capsule()
                        .foregroundColor(Color.G3)
                        .frame(width: 1.7, height: 72)
                        .padding(.bottom, 2)
                    ZStack {
                        Circle()
                            .frame(width: 31, height: 31)
                            .foregroundColor(state == .SECOND ? Color.Green2 : Color.G2)
                        Text("2")
                            .Label()
                            .foregroundColor(state == .SECOND ? Color.Green4 : Color.G4)
                    }
                }
                VStack(alignment: .leading, spacing: 52) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("어르신 정보")
                            .B1()
                            .foregroundColor(state == .FIRST ? Color.G6 : Color.G4)
                        Text("성함, 전화번호, 주민등록번호\n주민등록지, 현재 살고 계신 주소지")
                            .Cap3()
                            .foregroundColor(state == .FIRST ? Color.G5 : Color.G4)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("대리인(보호자) 정보")
                            .B1()
                            .foregroundColor(state == .SECOND ? Color.G6 : Color.G4)
                        Text("상세 관계, 신분증 촬영, 주소지, 서명")
                            .Cap3()
                            .foregroundColor(state == .SECOND ? Color.G5 : Color.G4)
                    }
                }
            }
            
            Spacer()
            CTAButton.CustomButtonView(
                style: .primary(isDisabled: false))
            {
                if state == .FIRST {
                    navigation.navigate(.MediHistoryView)
                } else {
                    navigation.navigate(.AgentInfoView)
                }
            } label: {
                Text("다음")
            }
        }
        .navigationBarBackButton()
        .padding([.top, .leading, .trailing], 20)
    }
}

struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        StepView(state: .FIRST)
    }
}

