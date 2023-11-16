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
            ZStack(alignment: .bottom) {
                switch(tab) {
                case .home:
                    NavigationStack(path: $navigation.homePath) { // TODO: NavigationStack 위로 빼기
                        HomeView(viewModel: viewModel)
                    }
                    .environmentObject(navigation)
                case .history:
                    PDFViewer(pdfData: pdfManager.PDFDatas.first )
                        .frame(maxHeight: .infinity)
                case .profile:
                    Text("내 정보")
                        .frame(maxHeight: .infinity)
                }
                
                CustomTabBarView(tab: $tab)
            }
            .ignoresSafeArea(edges: .bottom)
            if(viewModel.state == .guide) { GuideView() }
        }
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(NavigationManager())
    }
}
