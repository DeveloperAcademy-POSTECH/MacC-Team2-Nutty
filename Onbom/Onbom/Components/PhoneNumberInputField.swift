//
//  PhoneNumberInputField.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/10.
//

import SwiftUI

// TODO: 삭제하기
struct PhoneNumberInputField: View {
    @Binding var phoneNumber: String
    @FocusState private var focusField: Field?
    
    private enum Field: Hashable {
        case phone
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("휴대폰 번호")
                .foregroundColor(focusField != nil ? .Green4 : .G6)
                .Label()
            HStack {
                NumberInputField(placeholder: "",
                                 limitLength: 11,
                                 isSecure: false,
                                 content: $phoneNumber)
                .focused($focusField, equals: .phone)
            }
        }
        .onAppear {
            focusField = .phone
        }
    }
}

struct PhoneNumberInputField_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberInputField(phoneNumber: .constant("01012345678"))
    }
}
