//
//  PhoneNumberInputField.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/10.
//

import SwiftUI

struct PhoneNumberInputField: View {
    @Binding var phoneNumber: String
    
    var body: some View {
        HStack {
            NumberInputField(label: "휴대폰 번호",
                             placeholder: "",
                             limitLength: 11,
                             isSecure: false,
                             content: $phoneNumber)
            .padding()
        }
    }
}

struct PhoneNumberInputField_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberInputField(phoneNumber: .constant("01012345678"))
    }
}
