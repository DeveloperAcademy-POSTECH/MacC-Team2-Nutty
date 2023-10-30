//
//  FormTextField.swift
//  Onbom
//
//  Created by moon on 10/10/23.
//

import SwiftUI

struct FormTextField: View {
    
    @Binding var textInput: String
    @FocusState var focused: Bool
    let formSubject: String
    let placeHolder: String
    
    init(formSubject: String, placeHolder: String, textInput: Binding<String>) {
        self.formSubject = formSubject
        self.placeHolder = placeHolder
        _textInput = textInput
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text(formSubject)
                .foregroundColor(focused ? Color.Green4 : Color.G6)
                .Label()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(placeHolder, text: $textInput)
                .font(.custom("Pretendard-Medium", size: 16))
                .lineSpacing(16 / 2 * (100 - 100)/100)
                .kerning(-3/10)
                .foregroundColor(Color.B)
                .focused($focused)
                .padding(16)
                .background(RoundedRectangle(cornerRadius: 10)
                    .stroke(focused ? Color.Green4 : Color.Green1, lineWidth: 1.5))
                .tint(Color.Green4)
        }
    }
}

