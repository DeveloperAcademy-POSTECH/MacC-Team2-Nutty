//
//  IDCardDescriptionView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/01.
//

import SwiftUI

struct IDCardDescriptionView: View {
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
                .padding()
                HStack {
                    Text("주민등록증 또는 운전면허증을 준비해 주세요.\n사본이나 모니터 촬영, 임시 신분증은 쓸 수 없어요.")
                        .Cap2()
                        .foregroundColor(.G5)
                    Spacer()
                }
                .padding(.leading)
            }
            
            Spacer()
            
            //신분증 안내 사진?
            Rectangle()
                .foregroundColor(.gray)
                .padding()
            
            //CTA Button
            Button{
                homeNavigation.navigate(.IDCardOCRView)
            } label: {
                Text("다음")
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
