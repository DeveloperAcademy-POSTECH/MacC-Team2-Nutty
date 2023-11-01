//
//  Alert.swift
//  Onbom
//
//  Created by 금가경 on 2023/10/16.
//

import SwiftUI

struct Alert: View {
    let image: String
    let label : String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity, maxHeight: 42)
                .foregroundColor(.Green1)
            HStack {
                Image(image)
                Text(label)
                    .Cap4()
            }
            .padding(10)
        }
    }
}

struct Alert_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Alert(image: "security", label: "입력한 주민등록번호는 저장되지 않으니 안심하세요")
            Alert(image: "check", label: "안내 문구" )
            Alert(image: "info", label: "안내 문구" )
        }
    }
}
