//
//  MainView.swift
//  Onbom
//
//  Created by moon on 2023/10/06.
//

import SwiftUI

struct MainView: View {
    @StateObject private var navigation = NavigationManager()
    @StateObject var viewModel = MainViewModel()
    @State private var tab: Tabs = .home
    @State private var toast: ToastAlert? = nil
    private let pdfManager: PDFManager = .shared
    
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
                        MyInfoView(toast: $toast)
                    }
                    
                    CustomTabBarView(tab: $tab)
                }
                .ignoresSafeArea(edges: .bottom)
            }
            if(viewModel.state == .guide) { GuideView() }
        }
        .environmentObject(navigation)
        .environmentObject(viewModel)
        .toastView(toast: $toast)

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(NavigationManager())
    }
}
