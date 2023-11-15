//
//  ApplyTypeView.swift
//  Onbom
//
//  Created by moon on 10/7/23.
//

import SwiftUI

struct ApplyTypeView: View {
    @EnvironmentObject var navigation: NavigationManager
    @State private var isPrivacyPolicyViewPresented = true
    @State private var selected = 1
    
    let title: [String] = ["신규 신청", "갱신", "등급 변경"]
    let description: [String] = ["노인성 질병이 있는 경우에만 신청할 수 있어요", "2년에 한 번씩 갱신해 주세요", "환자의 상태가 변했을 때 신청할 수 있어요"]
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Text("장기요양등급\n신청 종류를 선택해 주세요")
                        .H1()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 48)
                    
                    VStack(spacing: 10) {
                        RadioButton.CustomButtonView(style: selected == 1 ? .oneSelected : .oneUnselected) {
                            selected = 1
                            isPrivacyPolicyViewPresented = true
                        } label : {
                            HStack {
                                VStack(alignment: .leading, spacing: 13) {
                                    Text("\(title[0])")
                                        .T2()
                                        .foregroundStyle(Color.B)
                                    Text("\(description[0])")
                                        .Cap3()
                                        .foregroundStyle(Color.G5)
                                }
                                Spacer()
                            }
                        }.tag(1)
                        
                        
                        
                        RadioButton.CustomButtonView(style: selected == 2 ? .oneSelected : .oneUnselected) {
                            selected = 2
                        } label : {
                            HStack {
                                VStack(alignment: .leading, spacing: 13) {
                                    Text("\(title[1])")
                                        .T2()
                                        .foregroundStyle(Color.G3)
                                    Text("\(description[1])")
                                        .Cap3()
                                        .foregroundStyle(Color.G3)
                                }
                                Spacer()
                            }
                        }
                        .tag(2)
                        .disabled(true)
                        
                        RadioButton.CustomButtonView(style: selected == 3 ? .oneSelected : .oneUnselected) {
                            selected = 3
                        } label : {
                            HStack {
                                VStack(alignment: .leading, spacing: 13) {
                                    Text("\(title[2])")
                                        .T2()
                                        .foregroundStyle(Color.G3)
                                    Text("\(description[2])")
                                        .Cap3()
                                        .foregroundStyle(Color.G3)
                                }
                                Spacer()
                            }
                        }
                        .tag(3)
                        .disabled(true)
                    }
                    Spacer()
                }
                .navigationBarBackButton()
                .padding(20)
                .sheet(isPresented: $isPrivacyPolicyViewPresented) {
                    PrivacyPolicyView(isPrivacyPolicyViewPresented: $isPrivacyPolicyViewPresented)
                        .presentationDetents([.fraction(0.4), .large])
                        .presentationDragIndicator(.hidden)
                }
            }
            if isPrivacyPolicyViewPresented {
                Color.black.opacity(0.3).ignoresSafeArea()
            }
        }
    }
    
    private func isCheckedYes() -> Bool {
        return true
    }
    
    private func isCheckedNo() -> Bool {
        return true
    }
}
struct ApplyTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyTypeView()
    }
}


