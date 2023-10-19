//
//  ApplyTypeView.swift
//  Onbom
//
//  Created by moon on 10/7/23.
//

import SwiftUI

struct ApplyTypeView: View {
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    
    var body: some View {
        VStack {
            Text("장기요양등급\n신청 종류를 선택해 주세요")
                .H2()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 48)
            
            Button{
                homeNavigation.navigate(.MediHistoryView)
            } label: {
                VStack (spacing: 13){
                    Text("대리인 신청")
                        .foregroundColor(Color.B)
                        .T3()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("노인성 질병이 있는 경우에만 신청할 수 있어요")
                        .foregroundColor(Color.G5)
                        .Cap3()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 16)
                .padding(.vertical, 22)
            }
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.G2))
            
            Button{
                homeNavigation.navigate(.StepView_First)
            } label: {
                VStack (spacing: 13){
                    Text("갱신")
                        .foregroundColor(Color.G3)
                        .T3()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("2년에 한 번씩 갱신해 주세요")
                        .foregroundColor(Color.G3)
                        .Cap3()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 16)
                .padding(.vertical, 22)
            }
            .disabled(true)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.G1))
            
            Button {
                
            } label: {
                VStack (spacing: 13){
                    Text("등급 변경")
                        .foregroundColor(Color.G3)
                        .T3()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("환자의 상태가 변했을 때 신청할 수 있어요")
                        .foregroundColor(Color.G3)
                        .Cap3()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 16)
                .padding(.vertical, 22)

            }
            .disabled(true)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.G1))
            
            
            Spacer()
        }
        .navigationBarBackButton()
        .padding(20)
        
    }
}

