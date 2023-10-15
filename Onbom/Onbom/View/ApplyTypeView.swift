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
                    Text("환자본인신청")
                        .foregroundColor(Color.B)
                        .T3()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("모든 뷰를 확인하고 싶다면 대리인으로 신청해주세요")
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
                    Text("대리인 신청")
                        .foregroundColor(Color.B)
                        .T3()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("모든 뷰를 확인할 수 있어요")
                        .foregroundColor(Color.G5)
                        .Cap3()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 16)
                .padding(.vertical, 22)
            }
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
        .padding(20)
        
    }
}

