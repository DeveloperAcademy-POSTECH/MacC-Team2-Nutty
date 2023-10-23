//
//  IDNumberInputField.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/10.
//

import SwiftUI

struct IDNumberInputField: View {
    @Binding var frontNumber: String
    @Binding var backNumber: String
    
    var body: some View {
        HStack {
            NumberInputField(label: "주민등록번호",
                             placeholder: "앞 6자리",
                             limitLength: 6,
                             isSecure: false,
                             content: $frontNumber)
            .padding(.leading)
            
            Image(systemName: "minus")
                .padding(.top)
                .padding(.top)
            
            NumberInputField(label: " ",
                             placeholder: "뒤 7자리",
                             limitLength: 7,
                             isSecure: false,
                             content: $backNumber)
            .padding(.trailing)
        }
    }
}

struct FrontIDNumberInputField_Previews: PreviewProvider {
    static var previews: some View {
        IDNumberInputField(frontNumber: .constant("123456"), backNumber: .constant("1234567"))
    }
}
