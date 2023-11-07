//
//  MainView.swift
//  Onbom
//
//  Created by moon on 2023/10/06.
//

import SwiftUI

struct MainView: View {
    @StateObject private var homeNavigation = HomeNavigationViewModel()
    @StateObject private var pdfManager = PDFManager()
    @State private var tab: Tabs = .home
    
    var body: some View {
        ZStack(alignment: .bottom){
            switch(tab) {
            case .home:
                NavigationStack(path: $homeNavigation.homePath) {
                    HomeView()
                }
                .environmentObject(homeNavigation)
                .environmentObject(pdfManager)
            case .history:
                PDFViewer(pdfData: pdfManager.PDFDatas.first )
                    .frame(maxHeight: .infinity)
            case .profile:
                Text("내 정보")
                    .frame(maxHeight: .infinity)
            }
            
            if(homeNavigation.homePath.count == 0){
                CustomTabBarView(tab: $tab)
            }
        }
        .ignoresSafeArea()
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(HomeNavigationViewModel())
            .environmentObject(PDFManager())
    }
}
