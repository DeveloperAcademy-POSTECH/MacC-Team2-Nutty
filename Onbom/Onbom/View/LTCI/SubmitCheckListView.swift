//
//  SubmitCheckListView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/10.
//

import SwiftUI

struct SubmitCheckListView: View {
    // MARK: - 유저 정보 관련 변수
    @EnvironmentObject var patient: Patient
    @EnvironmentObject var agent: Agent
    
    // MARK: - pdf 생성 관련 변수
    private let pdfManager: PDFManager = .shared
    
    // MARK: - navigation 관련 변수
    @State private var isSubmitLoadingViewPresented = false
    @EnvironmentObject var navigation : NavigationManager
    
    // MARK: - button 관련 변수
    @State private var isInfoReused = true
    
    var body: some View {
        VStack(spacing: 0) {
            h1
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        formCard("신청 종류", "신규", showChevron: false)
                        
                        h2("신청인", patient.name)
                        formCard("신청인 이름", patient.name, destination: .PatientInfoView_EditName)
                        formCard("신청인 전화번호", patient.hasMobile ? patient.phoneNumber : "전화번호 없음", destination: .PatientInfoView_EditPhoneNumber)
                        formCard("신청인 주민등록번호", patient.id, destination: .PatientInfoView_EditIDNumber)
                        addressCard("신청인 주민등록지", patient.address.toString, destination: .AddressFormView_Patient)
                        addressCard("신청인이 현재 살고 계신 주소지", patient.actualAddress.toString, destination: .AddressFormView_ActualPatient)
                        
                        h2("대리인", agent.name)
                        formCard("신청인과의 관계", agent.toStringRelation(), destination: .AgentInfoView_Edit)
                        formCard("신청인 주민등록번호", agent.id, destination: .IDCardConfirmEditView)
                        addressCard("대리인 주소지", agent.address.toString, destination: .AddressFormView_Agent)
                        
                        saveInfoButton
                        
                        Rectangle().fill(Color.clear).frame(height: 88)
                    }
                    .padding(.bottom, 34)
                }
                VStack {
                    Spacer()
                    LinearGradient(
                        stops: [
                            .init(color: .TPW, location : 0),
                            .init(color: .W, location : 0.48)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: 104)
                    .overlay {
                        VStack {
                            Spacer()
                            CTAButton.CustomButtonView(
                                style: .primary(isDisabled: false))
                            {
                                onClickButton()
                            } label: {
                                Text("신청하기")
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
        .padding(.top, 20)
        .navigationBarBackButton()
        .fullScreenCover(isPresented: $isSubmitLoadingViewPresented) {
            SubmitView()
        }
        .onAppear {
            navigation.isUserFromSubmitCheckListView = true
            print(navigation.isUserFromSubmitCheckListView)
        }
    }
}

extension SubmitCheckListView {
    
    private func onClickButton() {
        patient.updateDictionary()
        agent.updateDictionary()
        pdfManager.createPDF(documentURL: LTCIFormResource, patient: patient, agent: agent)
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            isSubmitLoadingViewPresented = true
        }
    }
}

extension SubmitCheckListView {
    private var h1: some View {
        Text("신청 정보를 확인해 주세요")
            .H1()
            .foregroundColor(.B)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding(.bottom, 12)
    }
    
    @ViewBuilder
    private var saveInfoButton: some View {
        Button {
            isInfoReused.toggle()
        } label: {
            HStack(alignment: .center) {
                if isInfoReused { Image("selectedCircle") }
                else { Image("defaultCircle") }
                Text("입력한 정보를 다음에도 사용할게요")
                    .Cap3()
                    .foregroundColor(Color.B)
            }
        }
        .padding(.top, 17)
        .buttonStyle(PlainButtonStyle())
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 20)
    }

    @ViewBuilder
    private func formCard(
        _ form: String,
        _ content: String,
        showChevron: Bool = true,
        destination: HomeRoute? = nil
    ) -> some View {
        HStack(alignment: .center) {
            Text(form)
                .B1()
                .foregroundColor(.G5)
            Spacer()
            HStack(alignment: .center){
                Text(content)
                    .B4()
                    .foregroundColor(.G5)
                if(showChevron) {
                    Image("chevronRight")
                        .foregroundColor(.G4)
                }
            }
            .onTapGesture {
                guard let destination = destination else { return }
                navigation.navigate(destination)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 25)
    }

    
    @ViewBuilder
    private func addressCard(
        _ form: String,
        _ content: String,
        destination: HomeRoute? = nil
    ) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                Text(form)
                    .B1()
                    .foregroundColor(.G5)
                Text(content)
                    .B3()
                    .foregroundColor(.G5)
            }
            Spacer()
            Image("chevronRight")
                .foregroundColor(.G4)
                .onTapGesture {
                    guard let destination = destination else { return }
                    navigation.navigate(destination)
                }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 25)
    }
    
    @ViewBuilder
    private func h2(_ title: String, _ name: String) -> some View {
        VStack(spacing: 4) {
            HStack(alignment: .center) {
                Text(title)
                    .Cap6()
                    .foregroundColor(.Green4)
                    .padding(4)
                    .padding(.horizontal, 3)
                    .background(RoundedRectangle(cornerRadius: 25).fill(Color.Green2))
                Text("\(name)님 정보")
                    .T2()
                    .foregroundColor(.G6)
                    .padding(.leading, -4)
                Spacer()
            }
            Divider()
        }
        .padding(.top, 28)
        .padding(.leading, 20)
    }
    
}

struct SubmitCheckListView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitCheckListView()
            .environmentObject(NavigationManager())
            .environmentObject(mockPatient)
            .environmentObject(mockAgent)
    }
}

