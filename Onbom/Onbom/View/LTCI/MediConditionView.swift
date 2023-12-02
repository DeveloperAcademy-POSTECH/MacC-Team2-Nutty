//
//  MediConditionView.swift
//  Onbom
//
//  Created by moon on 10/11/23.
//

import SwiftUI
import Combine

struct MediConditionView: View {
    @EnvironmentObject var navigation: NavigationManager
    @EnvironmentObject var patient: Patient
    @State private var hasInfectiousDisease : Bool? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            Text("어르신이 현재\n전염성 질환을 가지고 계신가요?")
                .H1()
                .foregroundColor(Color.B)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 48)
                .padding(.horizontal, 20)
            
            AlternativeForm(formSubject: "전염성 질환 보유 여부", answer: $hasInfectiousDisease)
                .padding(.horizontal, 20)
            Spacer()
            
            CTAButton.CustomButtonView(
                style: .primary(isDisabled: hasInfectiousDisease == nil))
            {
                guard let hasInfectiousDisease = hasInfectiousDisease else { return }
                patient.hasInfectiousDisease = hasInfectiousDisease
                navigation.navigate(.PatientInfoView)
            } label: {
                Text("다음")
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButton()
        .padding(.top, 20)
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
                    Text("아니요")
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
