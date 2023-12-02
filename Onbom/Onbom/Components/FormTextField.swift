//
//  FormTextField.swift
//  Onbom
//
//  Created by moon on 10/10/23.
//

import SwiftUI

struct FormTextField: View {
    
    @Binding var textInput: String
    @Binding var isWrong: Bool
    @Binding var abled: Bool
    @FocusState var focused: Bool
    let formSubject: String
    let placeHolder: String
    
    init(formSubject: String, placeHolder: String, textInput: Binding<String>, isWrong: Binding<Bool>, abled: Binding<Bool> = .constant(true)) {
        self.formSubject = formSubject
        self.placeHolder = placeHolder
        _textInput = textInput
        _isWrong = isWrong
        _abled = abled
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text(formSubject)
                .foregroundColor(subjectColor())
                .Label()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 4)
            ZStack(alignment: .trailing) {
                TextField(placeHolder, text: $textInput)
                    .font(.custom("Pretendard-Medium", size: 16))
                    .lineSpacing(16 / 2 * (100 - 100)/100)
                    .kerning(-3/10)
                    .foregroundColor(Color.B)
                    .focused($focused)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(strokeColor(), lineWidth: 1.5)
                            .background(RoundedRectangle(cornerRadius: 10).fill( abled ? .white.opacity(0.00001) : .G1))
                    )
                    .tint(Color.Green4)
                if(isWrong) {
                    Image("wrongInputField")
                        .padding(.trailing, 16)
                }
            }
        }
        .onTapGesture {
            focused = true
        }
    }
    
    func subjectColor() -> Color {
        if(abled == false) { return .G4 }
        else if(isWrong) { return .R }
        else if(focused) { return .Green4 }
        else { return .B }
    }
    
    func strokeColor() -> Color { // TODO: enum으로 관리하기
        if(abled == false) { return .G3 }
        else if(isWrong) { return .R }
        else if(focused) { return .Green4 }
        else { return .G3 }
    }
}

