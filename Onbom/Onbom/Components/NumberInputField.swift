//
//  NumberInputField.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/10.
//

import SwiftUI

struct NumberInputField: View {
    var placeholder: String
    var limitLength: Int
    var isSecure: Bool
    @Binding var content: String
    @FocusState var isFocused: Bool
    @State private var isValid = true
    
    var body: some View {
        VStack(alignment: .leading) {
            inputField
                .focused($isFocused)
                .padding()
                .keyboardType(.numberPad)
                .background() {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.5)
                        .foregroundColor(strokeColor)
                }
                .overlay {
                    if !isValid {
                        HStack {
                            Spacer()
                            Image("wrongInputField")
                                .padding(.trailing, 16)
                        }
                    }
                }
                .onChange(of: content) { newValue in
                    if content.count >= limitLength {
                        content = String(newValue.prefix(limitLength))
                        validation()
                    }
                }
                .onChange(of: isFocused) { _ in
                    validation()
                }
            }
        }
    }
    
    private var strokeColor: Color {
        if !isValid {
            return Color.red
        } else if isFocused {
            return Color.Green4
        } else {
            return Color.G3
        }
    }
    
    @ViewBuilder
    private var inputField: some View {
        if isSecure {
            SecureField(placeholder, text: $content)
        } else {
            TextField(placeholder, text: $content)
        }
    }
    
    private func validation() {
        if limitLength == 6 {
            isValid = content.isValidDateOfBirth()
        } else if limitLength == 7 {
            isValid = content.isValidIDBackNumber()
        }
    }
}

struct NumberInputField_Previews: PreviewProvider {
    static var previews: some View {
        NumberInputField(placeholder: "test",
                         limitLength: 6,
                         isSecure: false,
                         content: .constant(""))
    }
}
