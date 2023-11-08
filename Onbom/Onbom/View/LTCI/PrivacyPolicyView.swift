//
//  PrivacyPolicyView.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/10.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    
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
                VStack(spacing: 18) {
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
            .padding(.bottom, 8)
            CTAButton.CustomButtonView(
                style: .primary(isDisabled: !isAllCheck))
            {
                if isAllCheck {
                    // Date() 저장하기
                    isPrivacyPolicyViewPresented = false
                    homeNavigation.navigate(.StepView_First)
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
            // TODO: 에셋 교체
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
                .foregroundColor(isAllCheck ? .Green4 : .G3)
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
            // TODO: 에셋 교체
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
            // TODO: 패딩 확인하기 색상 확인하기
                Image("chevronRight")
            }
            // TODO: 현재 약관에 대한 페이지가 없어서 비활성화 처리. 근데 오른쪽 chevron을 눌러도 체크가 됨. 약관이 무조건 있을 꺼니까 상관 없을려나요?
            .disabled(true)
        }
        .fullScreenCover(isPresented: $isShowPrivacyPolicyDetail) {
            PrivacyPolicyDetailView(detail: policyText, isShowPrivacyPolicyDetail: $isShowPrivacyPolicyDetail)
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

// TODO: 임시 개인정보 처리 디테일 뷰. 자세한 컨텐츠 나오면 파일 분리 예정
struct PrivacyPolicyDetailView: View {
    var detail: String
    @Binding var isShowPrivacyPolicyDetail: Bool
    var body: some View {
        VStack {
            Text(detail)
            Button {
                isShowPrivacyPolicyDetail = false
            } label: {
                Text("닫기")
            }
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView(isPrivacyPolicyViewPresented: .constant(false))
    }
}
