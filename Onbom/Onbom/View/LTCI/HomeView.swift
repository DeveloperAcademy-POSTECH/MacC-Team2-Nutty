//
//  HomeView.swift
//  Onbom
//
//  Created by moon on 10/14/23.
//

import SwiftUI

// TODO: 글씨 크기 짤림 이슈 - 먀

struct HomeView: View {
    private let timer = Timer.publish(every: 8, on: .main, in: .common).autoconnect()
    @State private var selectedPage = 0
    @StateObject var viewModel = HomeViewModel()
    
    @EnvironmentObject var navigation: NavigationManager
    private let pdfManager: PDFManager = .shared
    @EnvironmentObject var patient: Patient
    @EnvironmentObject var agent: Agent
    let width = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                nav(transparant: false)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0){
                        adBanner
                        
                        LTCICard
                        
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
                .background(Color.G2)
            }
            
            .navigationDestination(for: HomeRoute.self) { route in // TODO: ViewModifier로 빼기
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
                case .SubmitCheckListView:              SubmitCheckListView(homeViewModel: self.viewModel)
                case .StepView_First:                   StepView(state: .FIRST)
                case .StepView_Second:                  StepView(state: .SECOND)
                case .PatientInfoView:                  PatientInfoView()
                case .AgentInfoView:                    AgentInfoView()
                case .AgentInfoDetailView:              AgentInfoDetailView()
                case .RejectView:                       RejectView()
                    
                case .PatientInfoView_EditPhoneNumber:  PatientInfoView(editState: .editPhoneNumber)
                case .PatientInfoView_EditIDNumber:     PatientInfoView(editState: .editIDNumber)
                default:                                RejectView()
                }
            }
            
            guideView
        }
    }
    @ViewBuilder
    private func nav(transparant: Bool = false) -> some View {
        CustomNavigationBar {
            HStack(alignment: .center, spacing: 5) {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 34)
                    .padding(.top, 4)
                    .padding(.leading, 20)
                Text("온봄")
                    .foregroundColor(Color.Green4)
                    .font(.custom("Dongle-Bold", size: 42))
            }
            .opacity(transparant ? 0.0000001 : 1)
            .onTapGesture(count: 3) { onReset() }
        } trailing: {
            Image("notification")
                .frame(width: 34, height: 34)
                .padding(.trailing, 20)
                .opacity(transparant ? 0.0000001 : 1)
                .onTapGesture(count: 3) { viewModel.onFlipCard() }
        }
    }
    
    @ViewBuilder
    private var guideView: some View {
        
        Group {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                nav(transparant: true)
                adBanner.appear(false)
                LTCICard
                Triangle()
                    .fill(.white)
                    .frame(width: 20, height: 10)
                VStack(alignment: .leading, spacing: 0){
                    Text("온봄이 처음이신가요?")
                        .B1()
                        .foregroundColor(.B)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    HStack(alignment: .center, spacing: 0) {
                        Text("신청하기 버튼을 눌러 ")
                            .Cap4()
                            .foregroundColor(.G6)
                        Text("장기요양등급")
                            .Cap4()
                            .foregroundColor(.Green4)
                        Text("을 받아보세요")
                            .Cap4()
                            .foregroundColor(.G6)
                    }
                    .padding(.leading, 16)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 18)
                .padding(.bottom, 16)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
                .padding(.horizontal, 10)
            }
        }
    }
    
    @ViewBuilder
    private var adBanner: some View {
        
        TabView(selection: $selectedPage){
            Image("Banner1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .tag(0)
            Image("Banner2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .tag(1)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(width: width, height: 84)
        .overlay(
            Text("\(selectedPage + 1) / 2")
                .foregroundStyle(Color.white)
                .font(.system(size: 10, weight: .regular))
                .padding(.vertical, 3.5)
                .padding(.horizontal, 5)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.TG1))
                .offset(x: -18, y: -12),
            alignment: .bottomTrailing
        )
        .onReceive(timer, perform: { _ in
            selectedPage = (selectedPage + 1) % 2
        })
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
    
    @ViewBuilder
    private var LTCICard: some View {
        
        if viewModel.state == .before {
            VStack(spacing: 30) {
                Text("집에서 간편하게\n장기요양등급 신청해 보세요")
                    .T1()
                    .foregroundColor(Color.B)
                    .lineSpacing(4)
                    .multilineTextAlignment(.center)
                    .padding(.top, 30)
                    .frame(maxWidth: .infinity)
                Image("MainView")
                CTAButton.CustomButtonView(
                    style: .main)
                {
                    navigation.navigate(.DescriptionView)
                } label: {
                    Text("지금 바로 신청하기")
                }
                .padding([.horizontal, .bottom], 20)
            }
            .background(RoundedRectangle(cornerRadius: 20).fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 5))
            .padding(20)
        }
        else if viewModel.state == .after {
            VStack(spacing: 0) {
                HStack(alignment: .center){
                    Text("장기요양등급신청")
                        .T2()
                        .foregroundColor(.B)
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .foregroundColor(Color.G4)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 12)
                
                HStack{
                    Text("신규 신청")
                        .Cap6()
                        .foregroundStyle(Color.Green4)
                        .font(.system(size: 11, weight: .regular))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 6)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.Green2))
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
                
                Rectangle()
                    .fill(Color.G3)
                    .frame(height: 98)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                ZStack(alignment: .leading) {
                    GeometryReader { geometry in
                        Capsule()
                            .fill(Color.G2)
                            .frame(height: 6.5)
                            .frame(maxWidth: .infinity)
                        Capsule()
                            .fill(Color.Green4)
                            .frame(height: 6.5)
                            .frame(maxWidth: geometry.size.width / 2)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 7)
                
                HStack {
                    Text("서류 전송")
                        .Cap6()
                        .foregroundColor(.G4)
                    Spacer()
                    Text("국민건강보험공단 확인중")
                        .Cap6()
                        .foregroundColor(.Green4)
                    Spacer()
                    Text("방문조사")
                        .Cap6()
                        .foregroundColor(.G4)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
                
                Text("국민건강보험공단에서 서류를 접수하면")
                    .Cap3()
                    .foregroundColor(.G5)
                    .multilineTextAlignment(.center)
                HStack(alignment: .center, spacing: 0){
                    Text("어르신이 계시는 주소로 방문조사")
                        .Label()
                        .foregroundColor(.B)
                    Text("가 진행돼요")
                        .Cap3()
                        .foregroundColor(.G5)
                }
                .padding(.bottom, 24)
            }
            .background(RoundedRectangle(cornerRadius: 20).fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 5))
            .padding(20)
            .onTapGesture {
                navigation.navigate(.ApplyHistoryView)
            }
        }
    }
    
    private func onReset() {
        viewModel.state = .before
        pdfManager.PDFDatas.removeAll()
        patient.reset()
        agent.reset()
        navigation.navigate(.OnboardingView)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
            .environmentObject(NavigationManager())
            .environmentObject(mockAgent)
            .environmentObject(mockPatient)
    }
}
