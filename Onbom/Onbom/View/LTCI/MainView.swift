//
//  MainView.swift
//  Onbom
//
//  Created by moon on 2023/10/06.
//

import SwiftUI

struct MainView: View {
    @StateObject private var navigation = NavigationManager()
    @StateObject private var pdfManager = PDFManager()
    @State private var tab: Tabs = .home
    
    var body: some View {
        ZStack(alignment: .bottom){
            switch(tab) {
            case .home:
                NavigationStack(path: $navigation.homePath) {
                    HomeView()
                }
                .environmentObject(navigation)
                .environmentObject(pdfManager)
                
            case .article:
                NavigationStack(path: $navigation.homePath) {
                    ArticleListView()
                }
                .environmentObject(navigation)
                
            case .profile:
                Text("내 정보")
                    .frame(maxHeight: .infinity)
            }
            
            if(navigation.homePath.count == 0) {
                CustomTabBarView(tab: $tab)
            }
        }
        .ignoresSafeArea()
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(NavigationManager())
            .environmentObject(PDFManager())
    }
}
