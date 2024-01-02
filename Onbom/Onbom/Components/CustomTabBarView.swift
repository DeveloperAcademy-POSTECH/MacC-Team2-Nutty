//
//  CustomTabBarView.swift
//  Onbom
//
//  Created by moon on 10/23/23.
//

import SwiftUI

enum Tabs {
    case home
    case article
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
                    .foregroundColor(tab == .home ? Color.Green4 : Color.G4)
                Text("홈")
                    .Cap5()
                    .foregroundColor(tab == .home ? Color.Green4 : Color.G5)
            }
            .frame(maxWidth: .infinity)
            .onTapGesture {
                tab = .home
            }
            
            VStack(spacing: 4){
                Image("dolbom_news")
                    .resizable()
                    .frame(width: 18, height: 20)
                    .foregroundColor(tab == .article ? Color.Green4 : Color.G4)
                Text("돌봄소식")
                    .Cap5()
                    .foregroundColor(tab == .article ? Color.Green4 : Color.G5)
            }
            .frame(maxWidth: .infinity)
            .onTapGesture {
                tab = .article
            }
            
            VStack(spacing: 4){
                Image("profile")
                    .resizable()
                    .frame(width: 18, height: 20)
                    .foregroundColor(tab == .profile ? Color.Green4 : Color.G4)
                Text("내 정보")
                    .Cap5()
                    .foregroundColor(tab == .profile ? Color.Green4 : Color.G5)
            }
            .frame(maxWidth: .infinity)
            .onTapGesture {
                tab = .profile
            }
        }
        .padding(.horizontal, 25)
        .padding(.top, 13)
        .padding(.bottom, 33)
        .background {
            Rectangle()
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .foregroundStyle(Color.white)
        }
        .background {
            Rectangle()
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .foregroundStyle(Color.G2.opacity(1))
                .offset(y: -1)
                .shadow(color: .black.opacity(0.05), radius: 40)
        }
        
    }
}


#Preview {
    CustomTabBarView(tab: .constant(.home))
}
