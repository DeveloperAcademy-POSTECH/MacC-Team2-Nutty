//
//  ConfirmIDCardView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/01.
//

import SwiftUI

struct ConfirmIDCardView: View {
    @EnvironmentObject var idCardViewModel: IDCardViewModel
    
    var body: some View {
        VStack {
            if let image = idCardViewModel.idCard.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("사진없음")
            }
            Text("이름: \(idCardViewModel.idCard.nameID.name)")
            Text("주민등록번호: \(idCardViewModel.idCard.nameID.idNumber)")
        }
    }
}
