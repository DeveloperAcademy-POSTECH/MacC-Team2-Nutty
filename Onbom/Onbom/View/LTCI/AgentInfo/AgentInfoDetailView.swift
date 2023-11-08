//
//  AgentInfoDetailView.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/09.
//

import SwiftUI

struct AgentInfoDetailView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("상세 관계를 모르겠어요")
                .H1()
                .foregroundColor(.B)
                .padding(.bottom, 54)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("가족")
                    .T2()
                    .foregroundColor(.G6)
                VStack(alignment: .leading, spacing: 8) {
                    Text("•  배우자, 직계혈족 및 형제자매")
                        .Cap1()
                    Text("•  직계혈족의 배우자")
                        .Cap1()
                    Text("•  배우자의 직계혈족, 배우자의 형제자매")
                        .Cap1()
                }
                .padding(.leading, 10)
            }
            .padding(.bottom, 28)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("친족")
                    .T2()
                    .padding(.bottom, 15)
                Text("•  8촌 이내의 혈족 및 4촌 이내 인척")
                    .Cap1()
                    .padding(.leading, 10)
                    .padding(.bottom, 43)
            }
            .foregroundColor(.G6)
            HStack {
                VStack(alignment: .leading) {
                    Text("국민건강보험공단 고객센터")
                        .B1()
                        .padding(.bottom, 1)
                    Text("기타 문의가 필요하신 경우")
                        .B3()
                }
                .foregroundColor(.G5)
                Spacer()
                Image("chevronRight")
                    .foregroundColor(.G4)
            }
            .padding(20)
            .frame(height: 86)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.G2))
            .onTapGesture {
                if let url = URL(string: "tel://15771000") {
                    UIApplication.shared.open(url)
                }
            }
            Spacer()
        }
        .navigationBarBackButton()
        .padding([.top, .leading, .trailing], 20)
    }
}

struct AgentInfoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AgentInfoDetailView()
    }
}
