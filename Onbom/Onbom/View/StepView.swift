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
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    
    init(state: StepViewState) {
        self.state = state
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Rectangle()
                .fill(Color.G3)
                .frame(width:60, height: 60)
                .padding(.bottom, 20)
            Text("장기요양등급 신규 신청을 위해")
                .Cap4()
                .foregroundColor(.G6)
                .padding(.bottom, 10)
            Text("신청대상자의 정보부터\n확인할게요")
                .H2()
                .foregroundColor(.B)
                .padding(.bottom, 32)
            
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                Text("1")
                    .Label()
                    .foregroundColor(state == .FIRST ? Color.PB4 : Color.G4)
                    .padding(.vertical, 9)
                    .padding(.horizontal, 12)
                    .background(Circle().fill(state == .FIRST ? Color.PB2 : Color.G2))
                    .overlay(
                        Rectangle()
                            .fill(Color.G3)
                            .frame(width: 1.7, height: 72)
                            .offset(y: 56)
                    )
                VStack(alignment: .leading, spacing: 8) {
                    Text("어르신 정보") 
                        .B1()
                        .foregroundColor(state == .FIRST ? Color.G6 : Color.G4)
                    Text("성함, 전화번호, 주민등록번호\n주민등록지, 현재 살고 계신 주소지")
                        .Cap3()
                        .foregroundColor(state == .FIRST ? Color.G5 : Color.G4)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 46)
            
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                Text("2")
                    .Label()
                    .foregroundColor(state == .SECOND ? Color.PB4 : Color.G4)
                    .padding(.vertical, 9)
                    .padding(.horizontal, 12)
                    .background(Circle().fill(state == .SECOND ? Color.PB2 : Color.G2))
                VStack(alignment: .leading, spacing: 8) {
                    Text("대리인(보호자) 정보")
                        .B1()
                        .foregroundColor(state == .SECOND ? Color.G6 : Color.G4)
                    Text("상세 관계, 신분증 촬영, 주소지, 서명")
                        .Cap3()
                        .foregroundColor(state == .SECOND ? Color.G5 : Color.G4)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Button {
            } label: {
                Text("다음")
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

