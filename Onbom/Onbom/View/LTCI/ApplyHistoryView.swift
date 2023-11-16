//
//  ApplyHistoryView.swift
//  Onbom
//
//  Created by moon on 11/6/23.
//

import SwiftUI

struct ApplyHistoryView: View {
    @EnvironmentObject var navigation: NavigationManager
    @EnvironmentObject var patient: Patient
    @EnvironmentObject var agent: Agent
    
    var body: some View {
        VStack {
            Text("장기요양등급 신청 현황")
                .H1()
                .foregroundColor(.B)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.horizontal, .top], 20)
            ScrollView {
                VStack(spacing: 0) {
                    formCard("신청 현황", "서류 전송 완료")
                    divider()
                    formCard("신청 종류", "신규")
                    formCard("신청인", "\(mockPatient.name)")
                    formCard("대리인", "김유진")
                    VStack(alignment: .leading) {
                        Text("신청인의 실주소지")
                            .B1()
                            .foregroundColor(.G5)
                            .padding(.bottom, 2)
                        HStack(spacing: 7) {
                            Image("Important")
                            Text("이 주소로 우편물 전송과 방문심사가 진행돼요")
                                .Cap4()
                                .foregroundColor(.G4)
                            Spacer()
                        }
                        .padding(.bottom, 12)
                        Text("\(mockPatient.actualAddress.toString)")
                            .B3()
                            .foregroundColor(.G5)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 22)
                    
                    divider()
                    VStack(alignment: .leading) {
                        HStack {
                            Text("전송 서류")
                                .B1()
                                .foregroundColor(.G5)
                                .padding(.bottom, 2)
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 22)
                    divider()
                    
                    formCard {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("국민건강보험공단 지사")
                                .B1()
                                .foregroundColor(.G6)
                            Text("신청 관련 문의가 필요할 때")
                                .Cap4()
                                .foregroundColor(.G5)
                        }
                    } _: {
                        Image("chevronRight")
                    }
                    
                    divider()
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text(" · 필요에 따라 공단에서 추가 서류를 요청할 수 있습니다.")
                            .T4()
                            .foregroundColor(.G4)
                        Text(" · 신청서를 제출한 날부터 30일 이내 등급 판정이 완료됩니다.")
                            .T4()
                            .foregroundColor(.G4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 22)
                }
                Spacer()
            }
        }
        .navigationBarBackButton()
    }
    
    @ViewBuilder
    private func formCard(_ form: String, _ content: String, axis: VerticalAlignment = .center) -> some View {
        HStack(alignment: axis) {
            Text(form)
                .B1()
                .foregroundColor(.G5)
            Spacer()
            Text(content)
                .B3()
                .foregroundColor(.G5)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 28)
    }
    
    @ViewBuilder
    private func formCard<L: View, R: View>(_ form: () -> L, _ content: () -> R, axis: VerticalAlignment = .center) -> some View {
        HStack(alignment: axis) {
            form()
            Spacer()
            content()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
    }
    
    @ViewBuilder
    private func divider() -> some View {
        Rectangle()
            .fill(Color.G2)
            .frame(height: 12)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    ApplyHistoryView()
        .environmentObject(Patient())
        .environmentObject(Agent())
}
