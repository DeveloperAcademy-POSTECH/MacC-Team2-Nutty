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
    
    init(_ formSubject: String, _ placeHolder: String, textInput: Binding<String>) {
        self.formSubject = formSubject
        self.placeHolder = placeHolder
        _textInput = textInput
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text(formSubject)
                .foregroundColor(focused ? Color.PB4 : Color.G6)
                .Label()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(placeHolder, text: $textInput)
                .focused($focused)
                .padding(16)
                .background(RoundedRectangle(cornerRadius: 10)
                    .stroke(focused ? Color.PB4 : Color.PB1, lineWidth: 1.5))
                .tint(Color.PB4)
        }
    }
}

