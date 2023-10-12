//
//  PrivacyPolicyView.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/10.
//

import SwiftUI

struct PrivacyPolicyView: View {

    private let policyTextArray = ["개인정보 제3자 제공 동의 (필수)", "민감정보 처리 동의 (필수)", "고유식별정보 처리 동의 (필수)"]
    @State private var isCheckArray = Array(repeating: false, count: 3)
    @State private var isAllCheck = false
    @State private var isShowPrivacyPolicyDetail = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                allCheckButton
                Divider()
                    .padding(.bottom, 18)
                    .padding(.top, 8)
                ForEach(Array(policyTextArray.enumerated()), id: \.element) { index, policyText in
                    HStack {
                        PrivacyPolicyLow(policyText: policyText, isCheck: $isCheckArray[index], isAllCheck: $isAllCheck)
                        Spacer()
                        Button {
                            isShowPrivacyPolicyDetail = true
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.G4)
                        }
                        // TODO: 왜인진 모르겠지만 policyText가 안바뀜
                        .fullScreenCover(isPresented: $isShowPrivacyPolicyDetail) {
                            PrivacyPolicyDetailView(detail: policyText, isShowPrivacyPolicyDetail: $isShowPrivacyPolicyDetail)
                        }
                    }
                    .padding(.bottom,18)
                }
                .onChange(of: isCheckArray) { newValue in
                    for i in 0..<3 {
                        if isCheckArray[i] == false {
                            return
                        }
                    }
                    isAllCheck = true
                }
                Button {
                    if isAllCheck {
                        // Date() 저장하기
                    }
                } label: {
                    Text("다음")
                }
                .disabled(!isAllCheck)
            }
        }
        .padding(20)
    }
    
    private var allCheckButton: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
                .foregroundColor(isAllCheck ? .PB4 : .G3)
            Text("개인정보 처리에 모두 동의합니다.")
                .H2()
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
    @Binding var isCheck: Bool
    @Binding var isAllCheck: Bool
    var body: some View {
        HStack {
            Image(systemName: "checkmark")
                .foregroundColor(isAllCheck || isCheck ? .PB4 : .G3)
            Text(policyText)
                .Cap2()
                .foregroundColor(.B)
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

// 임시 개인정보 처리 디테일 뷰. 자세한 컨텐츠 나오면 파일 분리 예정
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
        PrivacyPolicyView()
    }
}
