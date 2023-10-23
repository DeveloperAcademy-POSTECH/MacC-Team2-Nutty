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
    
    @EnvironmentObject var pdfManager: PDFManager
    @State private var questionInputs: [String] = ["이름", "주민등록번호", "주소", "핸드폰 번호"]
    @State private var answerInputs: [String] = Array(repeating: "", count: 4)
    @State var currentStep: Step = .one
    @State var modal = false

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
                    }.padding()
                    Button("개인정보 처리 동의 모달") {
                        modal = true
                    }
                }.sheet(isPresented: $modal) {

                }
                
            case .two:
                VStack {
                    ForEach(2..<questionInputs.count, id: \.self) { index in
                        InputField(label: questionInputs[index], placeholder: "입력해주세요",content: $answerInputs[index])
                    }
                    NavigationLink {
                        TempWriteSignatureView(answerInputs: $answerInputs)
                    } label: {
                        Text("다음")
                    }
                }
            }
        }
    }
}

struct TempWriteFormView_Previews: PreviewProvider {
    static var previews: some View {
        TempWriteFormView()
    }
}
