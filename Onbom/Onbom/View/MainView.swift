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
                        .navigationDestination(for: HomeRoute.self) { route in
                            switch(route) {
                            case .DescriptionView:                  DescriptionView()
                            case .ApplyTypeView:                    ApplyTypeView().toolbar(.hidden, for: .tabBar)
                            case .MediHistoryView:                  MediHistoryView()
                            case .MediConditionView:                MediConditionView()
                            case .IDCardDescriptionView:            IDCardDescriptionView()
                            case .IDCardConfirmEditView:            IDCardConfirmEditView()
                            case .AddressFormView_Patient:          AddressFormView(formType: .patient)
                            case .AddressFormView_ActualPatient:    AddressFormView(formType: .actualPatient)
                            case .AddressFormView_Agent:            AddressFormView(formType: .agent)
                            case .SignatureView:                    SignatureView()
                            case .SubmitCheckListView:              SubmitCheckListView()
                            case .StepView_First:                   StepView(state: .FIRST)
                            case .StepView_Second:                  StepView(state: .SECOND)
                            case .PatientInfoView:                  PatientInfoView()
                            case .AgentInfoView:                    AgentInfoView()
                            case .RejectView:                       RejectView()
                            default:                                RejectView()
                            }
                        }
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
        .onAppear() {
            UINavigationBar.setAnimationsEnabled(false)
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
