//
//  AgentInfoView.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/09.
//

import SwiftUI

struct AgentInfoView: View {
    let agentName = "김유진"
    let patientName = "김순옥"
    @State private var agentDetailType = ""
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    @State private var twoSelectedIndex = -1
    @State private var relationIndex = -1
    let yesNo = ["네", "아니요"]
    let relation = ["가족", "친족"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(agentName)님과 \(patientName)님의\n상세 관계를 선택해 주세요")
                .H2()
            
            Text("보호자이신가요?")
                .Label()
                .foregroundColor(.G6)
                .padding(.top, 36)
            
            HStack(spacing: 10) {
                ForEach(0..<yesNo.count, id: \.self) { index in
                    let twoStyle: RadioButtonStyle = twoSelectedIndex == index ? .twoSelected : .twoUnselected
                    RadioButton.CustomButtonView(style: twoStyle) {
                        twoSelectedIndex = index
                    } label: {
                        Text("\(yesNo[index])")
                    }
                }
            }
            .padding(.bottom, 36)
            
            Text("대리인 상세 관계")
                .Label()
                .foregroundColor(.G6)
            HStack(spacing: 10) {
                ForEach(0..<yesNo.count, id: \.self) { index in
                    let twoStyle: RadioButtonStyle = relationIndex == index ? .twoSelected : .twoUnselected
                    RadioButton.CustomButtonView(style: twoStyle) {
                        relationIndex = index
                    } label: {
                        Text("\(relation[index])")
                    }
                }
            }
            
            Spacer()
            
            NavigationLink {
                AgentInfoDetailView()
            } label: {
                Text("상세 관계를 모르겠어요")
                    .Label()
                    .foregroundColor(.G5)
                    .underline()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            
            CTAButton.CustomButtonView(style: .primary(isDisabled: twoSelectedIndex == -1 || relationIndex == -1)) {
                homeNavigation.navigate(.IDCardDescriptionView)
            } label: {
                Text("다음")
            }
            
        }
        .navigationBarBackButton()
        .padding(20)
    }
}

struct AgentInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AgentInfoView()
    }
}
