//
//  HomeView.swift
//  Onbom
//
//  Created by moon on 10/14/23.
//

import SwiftUI

struct HomeView: View {
    private let pdfManager: PDFManager = .shared
    @EnvironmentObject var mainViewModel: MainViewModel
    @EnvironmentObject var navigation: NavigationManager
    @EnvironmentObject var patient: Patient
    @EnvironmentObject var agent: Agent
    
    @State private var scrollSwitch: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                HomeNavigationBar(transparant: false, scrollToTop: self.$scrollSwitch)
                
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 0){
                            AdBanner()
                                .id("topPosition")
                            
                            if(mainViewModel.state == .after) { LTCICardBack() }
                            else { LTCICardFront() }
                            
                            callTaxiCard
                            
                            contentCard
                            
                            Spacer().frame(height: 100)
                        }
                    }
                    .onChange(of: scrollSwitch) { _ in
                        proxy.scrollTo("topPosition")
                    }
                }
            }
            .background(Color.G2)
        }
        .navigationDestination(for: HomeRoute.self) { route in
            switch(route) {
            case .OnboardingView:                   OnboardingView(isOnboarding: .constant(true))
            case .NotificationView:                 NotificationView()
            case .ApplyHistoryView:                 ApplyHistoryView()
            case .DescriptionView:                  DescriptionView()
            case .ApplyTypeView:                    ApplyTypeView().toolbar(.hidden, for: .tabBar)
            case .MediHistoryView:                  MediHistoryView()
            case .MediConditionView:                MediConditionView()
            case .IDCardDescriptionView:            IDCardDescriptionView()
            case .IDCardConfirmEditView:            IDCardConfirmEditView()
            case .AddressFormView_Patient:          AddressFormView(formType: .patient, address: patient.address)
            case .AddressFormView_ActualPatient:    AddressFormView(formType: .actualPatient, address: patient.actualAddress)
            case .AddressFormView_Agent:            AddressFormView(formType: .agent, address: agent.address)
            case .SignatureView:                    SignatureView()
            case .SubmitCheckListView:              SubmitCheckListView()
            case .StepView_First:                   StepView(state: .FIRST)
            case .StepView_Second:                  StepView(state: .SECOND)
            case .PatientInfoView:                  PatientInfoView()
            case .AgentInfoView:                    AgentInfoView()
            case .AgentInfoView_Edit:               AgentInfoView(isEdit: true)
            case .AgentInfoDetailView:              AgentInfoDetailView()
            case .PatientInfoView_EditName:         PatientInfoView(editState: .editName)
            case .PatientInfoView_EditPhoneNumber:  PatientInfoView(editState: .editPhoneNumber)
            case .PatientInfoView_EditIDNumber:     PatientInfoView(editState: .editIDNumber)
            case .CallTaxiView:                     CallTaxiView()
            case .Article3View:                     ArticleDetailView(articleName: "Article3")
            case .Article4View:                     ArticleDetailView(articleName: "Article4")
            case .Article7View:                     ArticleDetailView(articleName: "Article7")
            case .RejectView:                       RejectView()
            default:                                RejectView()
            }
            
        }
    }
    
    @ViewBuilder
    private var callTaxiCard: some View {
        HStack(alignment: .center, spacing: 0) {
            Image("callTaxi_asset")
                .padding(10)
                .padding(.leading, 20)
            VStack(alignment: .leading, spacing: 4) {
                Text("휠체어를 탄 어르신이 외출할 때")
                    .Cap3()
                    .foregroundColor(.G5)
                Text("동행콜 부르기")
                    .H2()
                    .foregroundColor(.G6)
            }
            .padding(.leading, 12)
            .padding(.vertical, 20)
            Spacer()
            Image("chevronRight")
                .foregroundColor(Color.G4)
                .padding(.trailing, 19)
        }
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white)
            .shadow(color: .black.opacity(0.05), radius: 5))
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .onTapGesture {
            navigation.navigate(.CallTaxiView)
        }
    }
    
    @ViewBuilder
    private var contentCard: some View {
        
        let divider = HStack(alignment: .center, spacing: 0) {
            Capsule()
                .fill(Color.G2)
                .frame(width: 1)
                .frame(maxHeight: .infinity)
        }
        
        HStack(alignment: .center, spacing: 0) {
            Spacer()
            col("stethoscope_no_back", "복지용구 신청")
                .onTapGesture { navigation.navigate(.Article4View) }
            divider
            col("syringe_no_back", "무료 독감접종")
                .onTapGesture { navigation.navigate(.Article7View) }
            divider
            col("safetyCenter", "치매안심센터 찾기")
                .onTapGesture { navigation.navigate(.Article3View) }
            Spacer()
        }
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white)
            .shadow(color: .black.opacity(0.05), radius: 5))
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func col(_ img: String, _ title: String)-> some View {
        VStack(alignment: .center, spacing: 8) {
            Image(img)
            Text(title)
                .Cap4()
                .foregroundColor(.G6)
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(MainViewModel(state: .before))
            .environmentObject(NavigationManager())
            .environmentObject(mockAgent)
            .environmentObject(mockPatient)
    }
}
