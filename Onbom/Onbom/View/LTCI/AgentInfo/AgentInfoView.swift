//
//  AgentInfoView.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/09.
//

import SwiftUI

struct AgentInfoView: View {
    let relation: [String] = ["가족", "친족"]
    @State var twoSelectedIndex : Int = -1
    @State private var isDisabled = true
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    @EnvironmentObject var agent: Agent
    @EnvironmentObject var patient: Patient
    
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
                    let twoStyle: RadioButtonStyle = twoSelectedIndex == index ? .twoSelected : .twoUnselected
                    RadioButton.CustomButtonView(style: twoStyle) {
                        twoSelectedIndex = index
                        isDisabled = false
                        agent.relation = relation[index]
                        print("\(relation[index])")
                    } label: {
                        Text(relation[index])
                    }
                }
            }
            Spacer()
            HStack {
                Spacer()
                NavigationLink {
                    AgentInfoDetailView()
                } label: {
                    Text("상세 관계를 모르겠어요")
                        .Label()
                        .foregroundColor(.G5)
                        .underline()
                }
                Spacer()
            }
            .padding(.bottom, 10)
            CTAButton.CustomButtonView(
                style: .primary(isDisabled: isDisabled))
            {
                homeNavigation.navigate(.IDCardDescriptionView)
            } label: {
                Text("다음")
            }
        }
        .navigationBarBackButton()
        .padding([.top, .leading, .trailing], 20)
    }
}

struct AgentInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AgentInfoView()
            .environmentObject(Agent())
            .environmentObject(Patient())
    }
}
