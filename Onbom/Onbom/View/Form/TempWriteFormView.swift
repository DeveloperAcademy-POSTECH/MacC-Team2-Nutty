//
//  TempWriteFormView.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/02.
//

import SwiftUI

struct TempWriteFormView: View {
    enum Step {
        case one
        case two
    }
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var pdfManager: PDFManager
    @State private var questionInputs: [String] = ["이름", "주민등록번호", "주소", "핸드폰 번호"]
    @State private var answerInputs: [String] = Array(repeating: "", count: 4)
    @State var currentStep: Step = .one
    let cgRectArray: [CGRect] = [CGRect(x: 150, y: 650, width: 140, height: 20),CGRect(x: 350, y: 650, width: 140, height: 20),CGRect(x: 150, y: 600, width: 140, height: 20),CGRect(x: 350, y: 565, width: 140, height: 20)]
    
    var body: some View {
        VStack {
            HStack {
                Button("<") {
                    currentStep = .one
                }.padding()
                Spacer()
            }
            switch currentStep {
            case .one:
                VStack {
                    ForEach(0..<questionInputs.count - 2, id: \.self) { index in
                        InputField(label: questionInputs[index], placeholder: "입력해주세요",content: $answerInputs[index])
                    }
                    Button("다음") {
                        currentStep = .two
                    }
                }
            case .two:
                VStack {
                    ForEach(2..<questionInputs.count, id: \.self) { index in
                        InputField(label: questionInputs[index], placeholder: "입력해주세요",content: $answerInputs[index])
                    }
                    Button("완료") {
                        addText()
                    }
                }
            }
        }
    }
    
    func addText() {
        guard !answerInputs.contains(where: { $0.isEmpty }) else { return }
        pdfManager.createPDF(documentURL: LTCIFormResource, newText: answerInputs, at: cgRectArray)
        presentationMode.wrappedValue.dismiss()
    }
}

struct TempWriteFormView_Previews: PreviewProvider {
    static var previews: some View {
        TempWriteFormView()
    }
}
