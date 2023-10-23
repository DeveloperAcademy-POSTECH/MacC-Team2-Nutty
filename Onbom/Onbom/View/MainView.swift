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
    var body: some View {
        TabView {
            NavigationStack(path: $homeNavigation.homePath) {
                HomeView()
                    .navigationDestination(for: HomeRoute.self) { route in
                        switch(route) {
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
            .tint(Color.G5)
            .tabItem {
                Image("home")
                Text("홈")
                    .Cap5()
            }
            
            PDFViewer(pdfData: pdfManager.PDFDatas.first )
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(HomeNavigationViewModel())
            .environmentObject(PDFManager())
    }
}
