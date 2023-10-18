//
//  IDCardDescriptionView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/01.
//

import SwiftUI

struct IDCardDescriptionView: View {
    @State private var presentIDCardOCR = false
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
  
    var body: some View {
        VStack {
            Group {
                HStack {
                    Text("김순옥님의 신분증을\n촬영할 수 있도록 준비해 주세요")
                        .H2()
                        .foregroundColor(.B)
                    Spacer()
                }
                
                Spacer()
                
                //신분증 안내 사진?
                Rectangle()
                    .foregroundColor(.gray)
                    .padding()
                //CTA Button
                Button {
                    presentIDCardOCR.toggle()
                } label: {
                    Text("다음")
                        .foregroundColor(Color.white)
                        .B1()
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                }
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.PB4))
                .padding()
            }
            .fullScreenCover(isPresented: $presentIDCardOCR) {
                IDCardOCRView(presentIDCardOCR: $presentIDCardOCR)
            }
        }
        .navigationBarBackButton()
    }
}

struct IDCardDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        IDCardDescriptionView()
    }
}
