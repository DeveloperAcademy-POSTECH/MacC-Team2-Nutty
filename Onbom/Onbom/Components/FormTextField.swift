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
    @FocusState var focused: Bool
    let formSubject: String
    let placeHolder: String
    
    init(formSubject: String, placeHolder: String, textInput: Binding<String>, isWrong: Binding<Bool>) {
        self.formSubject = formSubject
        self.placeHolder = placeHolder
        _textInput = textInput
        _isWrong = isWrong
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text(formSubject)
                .foregroundColor(isWrong ? Color.R : focused ? Color.Green4 : Color.G6)
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
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(isWrong ? Color.R : focused ? Color.Green4 : Color.Green1, lineWidth: 1.5))
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
}

