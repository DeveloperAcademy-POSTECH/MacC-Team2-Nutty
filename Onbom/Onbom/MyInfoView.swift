//
//  myInfoView.swift
//  Onbom
//
//  Created by 금가경 on 11/15/23.
//

import SwiftUI

struct MyInfoView: View {
    var body: some View {
        ZStack {
            VStack {
                Color.white
                Color.G2
            }
            ScrollView {
                Image("myInfoView")
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

#Preview {
    MyInfoView()
}
