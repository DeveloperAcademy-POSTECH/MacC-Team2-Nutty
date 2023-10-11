//
//  CityAddressInputField.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/10.
//

import SwiftUI

struct CityAddressInputField: View {
    var label: String
    var placeholder: String
    @Binding var content: String
    @FocusState private var isFocused: Bool
    var body: some View {
        VStack(alignment:.leading) {
            Text(label)
                .foregroundColor(.G6)
                .bold()
            
            TextField(placeholder, text: $content)
                .focused($isFocused)
                .padding()
                .background() {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isFocused ? Color.PB3 : Color.G3, lineWidth: 1.5)
                        .animation(.easeIn, value: isFocused)
                }
                .overlay {
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .padding()
                                .tint(.black)
                        }
                    }
                }
        }
    }
}
