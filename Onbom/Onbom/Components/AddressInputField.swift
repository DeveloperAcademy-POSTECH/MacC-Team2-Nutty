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
    
    var body: some View {
        VStack {
            InputField(label: label, buttonAction: geoCodefunc, placeholder: "예) C5, 남구 청암로 77", content: $cityAddress)
            InputField(placeholder: "상세주소", content: $detailAddress)
        }
        .padding()
    }
    
    private func geoCodefunc() {
        
    }
}

struct AddressInputField_Previews: PreviewProvider {
    static var previews: some View {
        AddressInputField(label: "주민등록지", cityAddress: .constant("포항"), detailAddress: .constant("포공"))
    }
}
