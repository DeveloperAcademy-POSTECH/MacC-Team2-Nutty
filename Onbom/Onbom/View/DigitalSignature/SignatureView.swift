//
//  SignatureView.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/10.
//

import SwiftUI

struct SignatureView: View {
    @ObservedObject var digitalSignatureManager = DigitalSignatureManager()
    var body: some View {
        VStack(alignment: .leading) {
            Text("서명을 해주세요")
                .H2()
            // Alert 넣기
            // TODO: 신청인/대리인 케이스 나누기
            Text("신청인 본인")
                .Label()
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
            Button("완료") {
            }
        }
        .padding(.horizontal, 20.0)
    }
    
    var deleteButton: some View {
        Button {
            digitalSignatureManager.resetPaths()
        } label: {
            Text("삭제")
                .B1()
        }
        .foregroundColor(.B)
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
    }
}
