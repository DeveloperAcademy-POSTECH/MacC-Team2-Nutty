//
//  NumberInputField.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/10.
//

import SwiftUI

struct NumberInputField: View {
    var label: String
    var placeholder: String
    var limitLength: Int
    var isSecure: Bool
    @Binding var content: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .foregroundColor(.G6)
                .bold()
            inputField
                .focused($isFocused)
                .padding()
                .keyboardType(.numberPad)
                .background() {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.5)
                        .foregroundColor(strokeColor)
                        .animation(.easeIn, value: isFocused)
                }
                .onChange(of: content) { newValue in
                    if newValue.count > limitLength {
                        content = String(newValue.prefix(limitLength))
                    }
                }
        }
    }
    
    private var strokeColor: Color {
        if isFocused {
            return Color.PB3
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
