//
//  HomeNavigationBar.swift
//  Onbom
//
//  Created by moon on 11/16/23.
//

import SwiftUI

struct HomeNavigationBar: View {
    let transparant: Bool
    init(transparant: Bool) {
        self.transparant = transparant
    }
    
    var body: some View {
        CustomNavigationBar {
            HStack(alignment: .center, spacing: 5) {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 34)
                    .padding(.top, 4)
                    .padding(.leading, 20)
                Text("온봄")
                    .foregroundColor(Color.Green4)
                    .font(.custom("Dongle-Bold", size: 42))
            }
            .opacity(transparant ? 0.0000001 : 1)
//            .onTapGesture(count: 3) { onReset() }
        } trailing: {
            Image("notification")
                .frame(width: 34, height: 34)
                .padding(.trailing, 20)
//                .onTapGesture(count: 3) { transparant ? nil : mainViewModel.onFlipCard() }
            // TODO: 함수 가져오기
        }
    
    }
}

#Preview {
    HomeNavigationBar(transparant: false)
}
