//
//  SignatureView.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/10.
//

import SwiftUI

struct SignatureView: View {
    @ObservedObject var digitalSignatureManager = DigitalSignatureManager()
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    @EnvironmentObject var agent: Agent
    @State private var isDisabled = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("서명을 해주세요")
                .H2()
            Alert(image: "security", label: "입력한 서명은 저장되지 않으니 안심하세요")
                .padding(.vertical, 8)
                .padding(.bottom, 30)
            Text("대리인 본인")
                .Label()
                .foregroundColor(Color.G6)
            ZStack {
                digitalSignatureManager.rectangle
                    .fill(Color.G2)
                    .cornerRadius(10)
                ForEach(digitalSignatureManager.paths.indices, id: \.self) { index in
                    DrawLine(currentPath: digitalSignatureManager.paths[index])
                        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                        .foregroundColor(.B)
                }
                DrawLine(currentPath: digitalSignatureManager.currentPath)
                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                    .foregroundColor(.B)
            }
            .overlay {
                if digitalSignatureManager.isStart {
                    VStack {
                        HStack {
                            Spacer()
                            deleteButton
                                .padding(20)
                        }
                        Spacer()
                    }
                } else {
                    Text("서명을 입력해 주세요")
                        .Cap2()
                        .foregroundColor(.G4)
                }
            }
            .frame(height: 146)
            .gesture(digitalSignatureManager.gesture())
            Spacer()
            CTAButton.CustomButtonView(
                style: .primary(isDisabled: digitalSignatureManager.paths.isEmpty))
            {
                agent.signature = digitalSignatureManager.paths
                homeNavigation.navigate(.SubmitCheckListView)
            } label: {
                Text("다음")
            }
        }
        .navigationBarBackButton()
        .padding([.top, .leading, .trailing], 20)
    }
    
    var deleteButton: some View {
        Button {
            digitalSignatureManager.resetPaths()
        } label: {
            Text("삭제")
                .B1()
        }
        .foregroundColor(.G6)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 54, height: 40)
                .foregroundColor(.TG2)
        }
    }
}

struct SignatureView_Previews: PreviewProvider {
    static var previews: some View {
        SignatureView()
            .environmentObject(Agent())
    }
}
