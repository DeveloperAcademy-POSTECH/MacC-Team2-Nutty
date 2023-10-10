//
//  SignatureView.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/10.
//

import SwiftUI

struct SignatureView: View {
    @ObservedObject var digitalSignatureManager = DigitalSignatureManager()
    @EnvironmentObject var pdfManager: PDFManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("서명을 해주세요")
                .H1()
            Text("신청인 본인")
                .Label()
            ZStack {
                digitalSignatureManager.rectangle
                    .fill(Color.G2)
                    .cornerRadius(10)
                ForEach(digitalSignatureManager.paths.indices, id: \.self) { index in
                    DrawLine(currentPath: digitalSignatureManager.paths[index])
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .foregroundColor(.blue)
                }
                DrawLine(currentPath: digitalSignatureManager.currentPath)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .foregroundColor(.blue)
            }
            .overlay {
                VStack {
                    HStack {
                        Spacer()
                        deleteButton
                            .padding(20)
                    }
                    Spacer()
                }
            }
            .frame(height: 250)
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
