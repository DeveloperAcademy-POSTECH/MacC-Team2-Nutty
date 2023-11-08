//
//  AgentInfoView.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/09.
//

import SwiftUI

struct AgentInfoView: View {
    // MARK: - 유저 데이터 관련 변수
    @EnvironmentObject var agent: Agent
    @EnvironmentObject var patient: Patient
    
    // MARK: - Navigation 관련 변수
    @EnvironmentObject var navigation: NavigationManager
    
    // MARK: - 라디오버튼 관련 변수
    let relation: [String] = ["가족", "친족"]
    @State var selectedItem : String = ""
    @State private var isDisabled = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(agent.name)님과 \(patient.name)님의\n상세 관계를 선택해 주세요")
                .H1()
                .foregroundColor(Color.B)
                .padding(.bottom, 48)
            Text("상세 관계")
                .Label()
                .foregroundColor(Color.G6)
                .padding(.bottom, 4)
            HStack {
                ForEach(0..<2, id: \.self) { index in
                    let style: RadioButtonStyle = selectedItem == relation[index] ? .twoSelected : .twoUnselected
                    
                    RadioButton.CustomButtonView(style: style) {
                        selectedItem = relation[index]
                        agent.relation = relation[index]
                        isDisabled = false
                    } label: {
                        Text(relation[index])
                    }
                }

            }
            Spacer()
            HStack {
                Spacer()
                Button {
                    navigation.navigate(.AgentInfoDetailView)
                } label: {
                    Text("상세 관계를 모르겠어요")
                        .Label()
                        .foregroundColor(.G5)
                        .padding(.bottom, 1)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.G4),
                            alignment: .bottom
                        )
                }
                Spacer()
            }
            .padding(.bottom, 10)
            CTAButton.CustomButtonView(
                style: .primary(
                    isDisabled: isDisabled))
            {
                if navigation.isUserFromSubmitCheckListView {
                    navigation.pop()
                } else {
                    navigation.navigate(.IDCardDescriptionView)
                }
            } label: {
                navigation.isUserFromSubmitCheckListView ? Text("수정 완료") : Text("다음")
            }
        }
        .navigationBarBackButton()
        .padding([.top, .leading, .trailing], 20)
        .onAppear {
            selectedItem = agent.relation
            if navigation.isUserFromSubmitCheckListView {
                isDisabled = false
            }
        }
    }
}

struct AgentInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AgentInfoView()
            .environmentObject(Agent())
            .environmentObject(Patient())
    }
}
