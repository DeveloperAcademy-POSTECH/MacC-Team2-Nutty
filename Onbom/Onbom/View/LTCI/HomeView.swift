//
//  HomeView.swift
//  Onbom
//
//  Created by moon on 10/14/23.
//

import SwiftUI

// TODO: 글씨 크기 짤림 이슈 - 먀

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
                            
                            HStack(spacing: 0) {
                                Text("본인 부담금 계산기")
                                    .B2()
                                    .foregroundColor(Color.B)
                                    .padding(.leading, 19)
                                    .padding(.vertical, 20)
                                Spacer()
                                Image("chevronRight")
                                    .foregroundColor(Color.G4)
                                    .padding(.trailing, 19)
                            }
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.white)
                                .shadow(color: .black.opacity(0.05), radius: 5))
                            .padding(.horizontal, 20)
                            .padding(.bottom, 25)
                            
                            
                            carouselContent
                            
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
            case .RejectView:                       RejectView()
                
            case .PatientInfoView_EditName:         PatientInfoView(editState: .editName)
            case .PatientInfoView_EditPhoneNumber:  PatientInfoView(editState: .editPhoneNumber)
            case .PatientInfoView_EditIDNumber:     PatientInfoView(editState: .editIDNumber)
            default:                                RejectView()
            }
            
        }
    }
    
    @ViewBuilder
    private var carouselContent: some View {
        VStack(spacing: 0) {
            Text("복지정보 한눈에 보기")
                .H2()
                .foregroundColor(Color.B)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.bottom, 5)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    let images = [Image("MainView_Green"),
                                  Image("MainView_Blue"),
                                  Image("MainView_Purple"),
                                  Image("MainView_Yellow"),
                                  Image("MainView_Pink"),
                                  Image("MainView_Brown"),]
                    let colors = [Color.init(hex: "E2F6E2"),
                                  Color.init(hex: "D6EDF8"),
                                  Color.init(hex: "DDDEF9"),
                                  Color.init(hex: "FFFBD4"),
                                  Color.init(hex: "FFE7F7"),
                                  Color.init(hex: "DFD6CE"),]
                    let circleColors = [Color.init(hex: "B4E8B4"),
                                        Color.init(hex: "9FD4ED"),
                                        Color.init(hex: "BFC1F6"),
                                        Color.init(hex: "FAF1A4"),
                                        Color.init(hex: "FECBED"),
                                        Color.init(hex: "D6C4B5"),]
                    let contents = ["치매가족휴가제로\n한 숨 돌려보세요",
                                    "부담을 덜어드리는\n노인돌봄종합서비스",
                                    "가장 가까운\n치매상담센터 찾기",
                                    "필요했던 복지용구\n한번에 신청해보세요",
                                    "인식표 나눔사업\n여기서 바로 알아보기",
                                    "장기요양등급,\n1분만에 시설등급 받기",]
                    
                    ForEach(0..<6) { i in
                        VStack(alignment: .leading, spacing: 0) {
                            ZStack {
                                Circle()
                                    .fill(circleColors[i])
                                    .frame(maxWidth: 64, maxHeight: 64)
                                images[i]
                            }
                            .padding(.bottom, 31)
                            Text(contents[i])
                                .foregroundColor(Color.B)
                                .T3()
                            Text("알림 설정하기")
                                .foregroundColor(Color.G5)
                                .Cap4()
                                .padding(.top, 5)
                        }
                        .padding(20)
                        .frame(width: 160, height: 194, alignment: .topLeading)
                        .background(colors[i])
                        .cornerRadius(12)
                        .padding(.leading, i == 0 ? 20 : 0)
                        .padding(.trailing, i == 5 ? 20 : 10)
                    }
                }
            }
        }
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
