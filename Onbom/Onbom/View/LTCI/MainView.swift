//
//  MainView.swift
//  Onbom
//
//  Created by moon on 2023/10/06.
//

import SwiftUI

struct MainView: View {
    @StateObject private var navigation = NavigationManager()
    private let pdfManager: PDFManager = .shared
    @State private var tab: Tabs = .home
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            NavigationStack(path: $navigation.homePath) {
                ZStack(alignment: .bottom) {
                    switch(tab) {
                    case .home:
                        HomeView()
                    case .article:
                        ArticleListView()
                    case .profile:
                        MyInfoView()
                    }
                    
                    CustomTabBarView(tab: $tab)
                }
                .ignoresSafeArea(edges: .bottom)
            }
            if(viewModel.state == .guide) { GuideView() }
        }
        .environmentObject(navigation)
        .environmentObject(viewModel)
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(NavigationManager())
    }
}
