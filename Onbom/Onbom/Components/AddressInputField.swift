//
//  AddressInputField.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/10.
//

import SwiftUI

struct AddressInputField: View {
    var label: String
    @Binding var cityAddress: String
    @Binding var detailAddress: String
    @Binding var isPostCodeViewPresented: Bool
    @FocusState var titleFocused: Bool
    @FocusState private var focusField: Field?

    private enum Field: Hashable {
        case cityAddress, detailAddress
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(label)
                .foregroundColor(focusField != nil || cityAddress.isEmpty ? .Green4 : .G6)
                .Label()
            
            CityAddressInputField(placeholder: "예) C5, 남구 청암로 77",
                                  content: $cityAddress)
            .focused($titleFocused)
            .onTapGesture {
                isPostCodeViewPresented = true
            }
            
            InputField(placeholder: "상세주소",
                       content: $detailAddress)
                .focused($focusField, equals: .detailAddress)
                .focused($titleFocused)
        }
        .onAppear {
            if !cityAddress.isEmpty {
                focusField = .detailAddress
            }
        }
    }
}

struct AddressInputField_Previews: PreviewProvider {
    static var previews: some View {
        AddressInputField(label: "주민등록지", cityAddress: .constant(""), detailAddress: .constant(""), isPostCodeViewPresented: .constant(false))
    }
}
