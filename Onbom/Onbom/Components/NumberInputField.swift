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
                .onChange(of: content) { newValue in
                    if newValue.count > limitLength {
                        content = String(newValue.prefix(limitLength))
                    }
                }
                .onChange(of: isFocused) { _ in
                    if limitLength == 6 {
                        isValid = content.isValidDateOfBirth()
                    } else if limitLength == 7 {
                        isValid = content.isValidIDBackNumber()
                    }
                }
        }
    }
    
    private var strokeColor: Color {
        if isFocused {
            return Color.Green4
        } else if !isValid {
            return Color.red
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
}

struct NumberInputField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            
        }
    }
}
