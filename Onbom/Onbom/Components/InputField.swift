//
//  InputField.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/09/27.
//

import SwiftUI

struct InputField: View {
    var label: String?
    var buttonAction: (() -> Void)?
    var placeholder: String
    @Binding var content: String
    // TODO: 다른 곳을 탭했을 때, isFocused가 false 되야 하는데 이건 추후에 다시 좀 해야할듯
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack(alignment:.leading) {
            if let label = label {
                Text(label)
                    .foregroundColor(.G6)
                    .Label()
            }
            TextField(placeholder, text: $content)
                .focused($isFocused)
                .padding()
                .background() {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isFocused ? Color.PB4 : Color.G3, lineWidth: 1.5)
                }
                .overlay {
                    if let buttonAction = buttonAction {
                        HStack {
                            Spacer()
                            Button {
                                buttonAction()
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
}

//struct InputField_Previews: PreviewProvider {
//    static var previews: some View {
//        InputField(label: "라벨", placeholder: "기본 문구", content: Binding.constant(""))
//    }
//}
