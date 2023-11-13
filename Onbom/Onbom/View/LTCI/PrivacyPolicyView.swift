//
//  PrivacyPolicyView.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/10.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @EnvironmentObject var navigation: NavigationManager
    
    private let policyTextArray = ["개인정보 제3자 제공 동의 (필수)", "민감정보 처리 동의 (필수)", "고유식별정보 처리 동의 (필수)"]
    @State private var isCheckArray = Array(repeating: false, count: 3)
    @State private var isAllCheck = false
    @Binding var isPrivacyPolicyViewPresented: Bool
    
    var body: some View {
        VStack(spacing: 41) {
            VStack(alignment: .leading) {
                allCheckButton
                Divider()
                    .padding(.bottom, 18)
                    .padding(.top, 8)
                VStack(spacing: 22) {
                    ForEach(Array(policyTextArray.enumerated()), id: \.element) { index, policyText in
                        HStack() {
                            PrivacyPolicyLow(policyText: policyText, isCheck: $isCheckArray[index], isAllCheck: $isAllCheck)
                        }
                    }
                }
                .onChange(of: isCheckArray) { newValue in
                    for i in 0..<3 {
                        if isCheckArray[i] == false {
                            return
                        }
                    }
                    isAllCheck = true
                }
            }
            CTAButton.CustomButtonView(
                style: .primary(isDisabled: !isAllCheck))
            {
                if isAllCheck {
                    isPrivacyPolicyViewPresented = false
                    navigation.navigate(.StepView_First)
                }
            } label: {
                Text("다음")
            }
        }
        .padding(.horizontal, 20.0)
        .padding(.top, 37)
    }
    
    private var allCheckButton: some View {
        HStack {
            Image(isAllCheck ? "selectedCircle" : "defaultCircle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
            Text("개인정보 처리에 모두 동의합니다.")
                .T1()
                .foregroundColor(.B)
            Spacer()
        }.onTapGesture {
            isAllCheck.toggle()
            for i in 0..<3 {
                isCheckArray[i] = isAllCheck
            }
        }
    }
    
}

struct PrivacyPolicyLow: View {
    var policyText: String
    @State private var isShowPrivacyPolicyDetail = false
    @Binding var isCheck: Bool
    @Binding var isAllCheck: Bool
    var body: some View {
        HStack(spacing: 18) {
            Image(systemName: "checkmark")
                .foregroundColor(isAllCheck || isCheck ? .Green4 : .G4)
                .font(.system(size: 12, weight: .bold))
            Text(policyText)
                .Cap3()
                .foregroundColor(.B)
            Spacer()
            Button {
                isShowPrivacyPolicyDetail = true
            } label: {
                Image("chevronRight")
            }
        }
        .fullScreenCover(isPresented: $isShowPrivacyPolicyDetail) {
            PrivacyPolicyDetailView(isShowPrivacyPolicyDetail: $isShowPrivacyPolicyDetail)
        }
        .onTapGesture {
            if isAllCheck {
                isCheck.toggle()
                isAllCheck = false
            } else {
                isCheck.toggle()
            }
        }
        .onChange(of: isAllCheck) { newValue in
            if isAllCheck {
                isCheck = isAllCheck
            }
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView(isPrivacyPolicyViewPresented: .constant(false))
    }
}
