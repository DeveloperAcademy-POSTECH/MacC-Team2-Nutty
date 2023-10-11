//
//  ConfirmIDCardView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/01.
//

import SwiftUI

struct ConfirmIDCardView: View {
    @EnvironmentObject var applicationViewModel: ApplicationViewModel
    
    var body: some View {
        VStack {
            if let image = applicationViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("사진없음")
            }
            Text("이름: \(applicationViewModel.agentName)")
            Text("주민등록번호: \(applicationViewModel.agentID)")
        }
    }
}
