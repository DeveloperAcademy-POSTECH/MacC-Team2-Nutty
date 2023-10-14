//
//  MediConditionView.swift
//  Onbom
//
//  Created by moon on 10/11/23.
//

import SwiftUI
import Combine

struct MediConditionView: View {
    
    @ObservedObject private var viewModel = MediConditionViewModel()
    
    var body: some View {
        VStack(spacing: 0){
            Text("현재 전염성 질병 또는\n정신질환을 가지고 계신가요?")
                .H2()
                .foregroundColor(Color.B)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 48)
            
            AlternativeForm(formSubject: "전염성 질병 보유 여부", answer: $viewModel.hasInfectiousDisease)
                .padding(.bottom, 36)
            AlternativeForm(formSubject: "정신 질환 보유 여부", answer: $viewModel.hasMentalDisorder)
            
            Spacer()
            
            Button {
            } label: {
                Text("다음")
                    .foregroundColor(Color.white)
                    .B1()
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
            }
            .background(RoundedRectangle(cornerRadius: 16).fill(viewModel.formIsValid ? Color.PB4 : Color.PB3))
        }
        .padding(20)
    }
}

fileprivate
struct AlternativeForm: View {
    let formSubject: String
    @Binding var answer: Bool?
    
    init(formSubject: String, answer: Binding<Bool?>){
        self.formSubject = formSubject
        self._answer = answer
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text(formSubject)
                .Label()
                .foregroundColor(Color.G6)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 10) {
                Button {
                    self.answer = true
                } label: {
                    Text("네")
                        .B4()
                        .foregroundColor(isCheckedYES() ? Color.PB4 : Color.G4)
                        .padding(16)
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(isCheckedYES() ? Color.PB4 : Color.G2, lineWidth: 1.2))
                    .background(RoundedRectangle(cornerRadius: 10).fill(isCheckedYES() ? Color.PB2 : Color.G2)
                )
                
                
                Button {
                    self.answer = false
                } label: {
                    Text("아니요")
                        .B4()
                        .foregroundColor(isCheckedNO() ? Color.PB4 : Color.G4)
                        .padding(16)
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(isCheckedNO() ? Color.PB4 : Color.G2, lineWidth: 1.2))
                    .background(RoundedRectangle(cornerRadius: 10).fill(isCheckedNO() ? Color.PB2 : Color.G2)
                )
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func isCheckedYES() -> Bool {
        guard let answer = answer else {
            return false
        }
        return answer == true
    }
    
    private func isCheckedNO() -> Bool {
        guard let answer = answer else {
            return false
        }
        return answer == false
    }
}
