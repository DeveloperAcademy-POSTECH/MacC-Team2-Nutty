//
//  CustomTabBarView.swift
//  Onbom
//
//  Created by moon on 10/23/23.
//

import SwiftUI

enum Tabs {
    case home
    case history
    case profile
}

struct CustomTabBarView: View {
    @Binding var tab: Tabs
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(spacing: 4){
                Image("home")
                    .resizable()
                    .frame(width: 18, height: 20)
                    .foregroundColor(tab == .home ? Color.PB4 : Color.G4)
                Text("홈")
                    .Cap5()
                    .foregroundColor(tab == .home ? Color.PB4 : Color.G5)
            }
            .frame(maxWidth: .infinity)
            .onTapGesture {
                tab = .home
            }
            
            VStack(spacing: 4){
                Image("form_history")
                    .resizable()
                    .frame(width: 18, height: 20)
                    .foregroundColor(tab == .history ? Color.PB4 : Color.G4)
                Text("신청 내역")
                    .Cap5()
                    .foregroundColor(tab == .history ? Color.PB4 : Color.G5)
            }
            .frame(maxWidth: .infinity)
            .onTapGesture {
                tab = .history
            }
            
            VStack(spacing: 4){
                Image("profile")
                    .resizable()
                    .frame(width: 18, height: 20)
                    .foregroundColor(tab == .profile ? Color.PB4 : Color.G4)
                Text("내 정보")
                    .Cap5()
                    .foregroundColor(tab == .profile ? Color.PB4 : Color.G5)
            }
            .frame(maxWidth: .infinity)
            .onTapGesture {
                tab = .profile
            }
        }
        .padding(.horizontal, 25)
        .padding(.top, 13)
        .padding(.bottom, 33)
        .background(Color.white)
        
        .clipShape(
            .rect(
                topLeadingRadius: 24,
                topTrailingRadius: 24
            )
        )
    }
}

