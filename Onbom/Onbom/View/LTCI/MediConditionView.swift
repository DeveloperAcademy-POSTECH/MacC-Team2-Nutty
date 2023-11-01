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
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    @EnvironmentObject var patient: Patient
    
    var body: some View {
        VStack(spacing: 0){
            Text("어르신이 현재 전염성 질병 또는\n정신질환을 가지고 계신가요?")
                .H1()
                .foregroundColor(Color.B)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 48)
            
            AlternativeForm(formSubject: "전염성 질병 보유 여부", answer: $viewModel.hasInfectiousDisease)
                .padding(.bottom, 36)
            AlternativeForm(formSubject: "정신 질환 보유 여부", answer: $viewModel.hasMentalDisorder)
            
            Spacer()
            
            CTAButton.CustomButtonView(
                style: .primary(isDisabled: !viewModel.formIsValid))
            {
                patient.hasInfectiousDisease = viewModel.hasInfectiousDisease ?? false
                patient.hasMentalDisorder = viewModel.hasMentalDisorder ?? false
                homeNavigation.navigate(.PatientInfoView)
            } label: {
                Text("다음")
            }
        }
        .navigationBarBackButton()
        .padding([.top, .leading, .trailing], 20)
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
                .padding(.bottom, 4)
            HStack(spacing: 10) {
                RadioButton.CustomButtonView(style: isCheckedYES() ? .twoSelected : .twoUnselected) {
                        answer = true
                    } label: {
                        Text("예")
                    }
                RadioButton.CustomButtonView(style: isCheckedNO() ? .twoSelected : .twoUnselected) {
                    self.answer = false
                } label: {
                    Text("아니오")
                }
            }
        }
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

struct MediConditionView_Previews: PreviewProvider {
    static var previews: some View {
        MediConditionView()
    }
}
