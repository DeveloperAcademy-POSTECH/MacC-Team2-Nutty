//
//  TempWriteSignatureView.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/04.
//

import SwiftUI
import PDFKit

struct TempWriteSignatureView: View {
    @ObservedObject var digitalSignatureManager = DigitalSignatureManager()
    @EnvironmentObject var pdfManager: PDFManager
    @Binding var answerInputs: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("전자 서명")
                .font(.title)
                .bold()
            ZStack {
                digitalSignatureManager.rectangle
                    .fill(Color.G2)
                    .cornerRadius(20)
                ForEach(digitalSignatureManager.paths.indices, id: \.self) { index in
                    DrawLine(currentPath: digitalSignatureManager.paths[index])
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .foregroundColor(.blue)
                }
                DrawLine(currentPath: digitalSignatureManager.currentPath)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .foregroundColor(.blue)
                
            }
            .frame(height: 250)
            .gesture(digitalSignatureManager.gesture())
            
            HStack {
                Button("초기화") {
                    digitalSignatureManager.resetPaths()
                }
                Spacer()
                Button("완료") {
                    completeForm()
                }
            }
        }
        .padding(.horizontal, 20.0)
    }
    
    func completeForm() {
        guard !answerInputs.contains(where: { $0.isEmpty }) else { return }
//        pdfManager.createPDF(documentURL: LTCIFormResource, newText: answerInputs, signature: digitalSignatureManager.paths, image: UIImage(systemName: "person.text.rectangle")!, imageSize: UIImage(systemName: "person.text.rectangle")!.size)
    }
}

struct TempWriteSignatureView_Previews: PreviewProvider {
    @State private static var answerInputs: [String] = []
    static var previews: some View {
        TempWriteSignatureView(answerInputs: $answerInputs)
    }
}
