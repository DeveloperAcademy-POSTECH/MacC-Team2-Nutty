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
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(agentName)님과 \(patientName)님의\n상세 관계를 선택해 주세요")
                .H2()
            Text("상세 관계")
                .Label()
            HStack {
                Button {
                    agentDetailType = "가족"
                } label: {
                    Text("가족")
                        .B3()
                }
                Button {
                    agentDetailType = "친족"
                } label: {
                    Text("친족")
                        .B3()
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
            Button {
                homeNavigation.navigate(.IDCardDescriptionView)
            } label: {
                Text("다음")
            }
            
        }
        .padding(20)
}
}

struct AgentInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AgentInfoView()
    }
}
