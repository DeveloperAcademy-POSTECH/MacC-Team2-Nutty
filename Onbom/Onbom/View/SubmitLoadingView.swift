//
//  SubmitLoadingView.swift
//  Onbom
//
//  Created by 금가경 on 2023/10/23.
//

import SwiftUI

struct SubmitLoadingView: View {
    @State private var isSubmitViewPresented = false
    
    var body: some View {
        VStack {
            Text("국민건강보험공단에 보내고 있어요")
                .H2()
                .foregroundColor(.B)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 162)
                .padding(.top, 45)
            Image("SubmitLoadingView")
    
            Spacer()
        }
        .navigationDestination(isPresented: $isSubmitViewPresented, destination: {
            SubmitView()
        })
        .navigationBarBackButtonHidden(true)

        .padding(20.0)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                isSubmitViewPresented = true
            }
        }
    }
}



struct SubmitLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitLoadingView()
    }
}
