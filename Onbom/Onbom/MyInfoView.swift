//
//  myInfoView.swift
//  Onbom
//
//  Created by 금가경 on 11/15/23.
//

import SwiftUI

struct MyInfoView: View {
    @Binding var toast: ToastAlert?

    var body: some View {
        ZStack {
            VStack {
                Color.white
                Color.G2
            }
            Image("myInfoView")
                .resizable()
                .scaledToFit()
            .onTapGesture {
                toast = ToastAlert(message: "지금은 서비스 준비중이에요")
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct MyInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyInfoView(toast: .constant(ToastAlert(message: "test")))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
    }
}
