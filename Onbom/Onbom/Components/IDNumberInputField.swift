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
    @FocusState var titleFocused: Bool
    @FocusState private var focusField: Field?

    private enum Field: Hashable {
        case front, back
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("주민등록번호")
                .foregroundColor(focusField != nil ? .Green4 : .G6)
                .Label()
                .padding(.leading, 20)
            HStack {
                NumberInputField(placeholder: "앞 6자리",
                                 limitLength: 6,
                                 isSecure: false,
                                 content: $frontNumber
                )
                .focused($focusField, equals: .front)
                .padding(.leading, 20)
                // TODO: 느낌표 넣어야함
                
                Image(systemName: "minus")
                // TODO: Rectangle width: 7이고, height:1로 바꾸기
                
                NumberInputField(placeholder: "뒤 7자리",
                                 limitLength: 7,
                                 isSecure: false,
                                 content: $backNumber)
                .padding(.trailing, 20)
                .focused($focusField, equals: .back)
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button {
                                hideKeyboard()
                            } label: {
                                Text("완료")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct FrontIDNumberInputField_Previews: PreviewProvider {
    static var previews: some View {
        IDNumberInputField(frontNumber: .constant("123456"), backNumber: .constant("1234567"))
    }
}
