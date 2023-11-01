//
//  SubmitLoadingView.swift
//  Onbom
//
//  Created by 금가경 on 2023/10/23.
//

import SwiftUI

struct SubmitLoadingView: View {
    
    var body: some View {
        VStack {
            Text("국민건강보험공단에\n보내고 있어요")
                .H1()
                .foregroundColor(.B)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 100)
                .padding(.top, 45)
            Image("SubmitLoadingView")
    
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .padding(20.0)
    }
}



struct SubmitLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitLoadingView()
    }
}
