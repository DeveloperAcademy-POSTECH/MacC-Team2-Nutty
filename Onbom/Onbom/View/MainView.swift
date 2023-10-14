//
//  MainView.swift
//  Onbom
//
//  Created by moon on 2023/10/06.
//

import SwiftUI

struct MainView: View {
    @State private var navigationPath: [Int] = []
    
    var body: some View {
        TabView {
            }
            .tint(Color.G5)
            .tabItem {
                Image("home")
                Text("홈")
                    .Cap5()
            }
            Text("신청 내역 화면")
            .tabItem {
                Image("form_history")
                Text("신청 내역")
                    .Cap5()
            }
            Text("프로필 화면")
            .tabItem {
                Image("profile")
                Text("내 정보")
                    .Cap5()
            }
        }
        .tint(Color.PB4)
    }
}
