//
//  ApplyTypeView.swift
//  Onbom
//
//  Created by moon on 10/7/23.
//

import SwiftUI

struct ApplyTypeView: View {
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    let title: [String] = ["신규 신청", "갱신", "등급 변경"]
    let description: [String] = ["노인성 질병이 있는 경우에만 신청할 수 있어요", "2년에 한 번씩 갱신해 주세요", "환자의 상태가 변했을 때 신청할 수 있어요"]
    
    @State private var isPrivacyPolicyViewPresented = false
    
    @State var oneSelectedIndex : Int = -1
    
    var body: some View {
        ZStack {
            VStack {
                Text("장기요양등급\n신청 종류를 선택해 주세요")
                    .H1()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 48)
                
                VStack(spacing: 10) {
                    ForEach(0..<title.count, id: \.self) { index in
                        let oneStyle: RadioButtonStyle = oneSelectedIndex == index ? .oneSelected : .oneUnselected
                        
                        RadioButton.CustomButtonView(style: oneStyle) {
                            oneSelectedIndex = index
                            isPrivacyPolicyViewPresented = true
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 13) {
                                    if index == 0 {
                                        Text("\(title[index])")
                                            .T2()
                                        Text("\(description[index])")
                                            .Cap3()
                                    }
                                    else {
                                        Text("\(title[index])")
                                            .T2()
                                            .foregroundColor(.G3)
                                        Text("\(description[index])")
                                            .Cap3()
                                            .foregroundColor(.G3)
                                    }
                                }
                                Spacer()
                            }
                        }
                        .disabled(index > 0)
                    }
                }
                Spacer()
            }
            .navigationBarBackButton()
            .padding(20)
            .sheet(isPresented: $isPrivacyPolicyViewPresented) {
                PrivacyPolicyView(isPrivacyPolicyViewPresented: $isPrivacyPolicyViewPresented)
                    .presentationDetents([.fraction(0.4)])
            }
            
            if isPrivacyPolicyViewPresented {
                Color.black.opacity(0.3).ignoresSafeArea()
            }
        }
    }
}
struct ApplyTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyTypeView()
    }
}


