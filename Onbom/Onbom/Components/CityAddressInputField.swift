//
//  CityAddressInputField.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/10.
//

import SwiftUI

struct CityAddressInputField: View {
    var placeholder: String
    @Binding var content: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack(alignment:.leading) {
            TextField(placeholder, text: $content)
                .focused($isFocused)
                .padding()
                .background() {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(content.isEmpty ? Color.Green4 : Color.G3, lineWidth: 1.5)
                }
                .overlay {
                    HStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .padding()
                            .foregroundColor(.B)
                    }
                }
        }
    }
}
