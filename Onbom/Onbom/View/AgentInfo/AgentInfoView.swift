//
//  AgentInfoView.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/09.
//

import SwiftUI

struct AgentInfoView: View {
    @State private var isGuardian = false
    @State private var agentDetailType = false
    var body: some View {
        VStack(alignment: .leading) {
            Text("환자분과의\n상세 관계를 선택해 주세요")
                .H1()
            Text("보호자이신가요?")
                .Label()
            HStack {
                Button {
                    isGuardian = true
                } label: {
                    Text("네")
                        .B3()
                }
                Button {
                    isGuardian = false
                } label: {
                    Text("아니요")
                        .B3()
                }
            }
            Text("대리인 상세 관계")
                .Label()
            HStack {
                Button {
                    agentDetailType = true
                } label: {
                    Text("가족")
                        .B3()
                }
                Button {
                    agentDetailType = false
                } label: {
                    Text("친족")
                        .B3()
                }
            }
            Spacer()
            HStack {
                Spacer()
                Text("상세 관계를 모르겠어요")
                    .Label()
                    .foregroundColor(.G5)
                    .underline()
                Spacer()
            }
            Button {
                
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
