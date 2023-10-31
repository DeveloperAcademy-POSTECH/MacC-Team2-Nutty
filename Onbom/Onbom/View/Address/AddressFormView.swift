//
//  AddressFormView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/10.
//

import SwiftUI

struct AddressFormView: View {
    var formType: AddressFormType
    @State private var isPostCodeViewPresented = false
    @State private var showActualAddressCheckView = false
    @State private var address = Address(cityAddress: "", detailAddress: "")
    @State private var isKeyboardVisible = false
    @EnvironmentObject var patient: Patient
    @EnvironmentObject var agent: Agent
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    
    var isAddressFilled: Bool {
        !address.cityAddress.isEmpty && !address.detailAddress.isEmpty
    }

    var name: String {
        switch formType {
        case .patient, .actualPatient:
            return patient.name
        case .agent:
            return agent.name
        }
    }
    
    var alertMessage: String {
        switch formType {
        case .patient:
            return "주민등록증에 적혀 있는 가장 최근 주소를 이야기해요"
        case .actualPatient:
            return "방문조사와 우편물 수령을 위한 주소가 필요해요"
        default:
            return ""
        }
    }
    
    var alertImage: Image {
        switch formType {
        case .patient, .actualPatient:
            return Image(systemName: "exclamationmark.circle.fill")
        default:
            return Image("")
        }
    }
    
    var titleMessage: String {
        switch formType {
        case .patient:
            return "\(name)님의\n주민등록지를 입력해 주세요"
        case .actualPatient:
            return "\(name)님이 현재 살고 계신\n주소지를 입력해 주세요"
        case .agent:
            return "\(name)님의\n주소지를 입력해 주세요"
        }
    }
    
    var addressInputFieldTitle: String {
        switch formType {
        case .patient:
            return "주민등록지"
        case .actualPatient:
            return "현재 살고 계신 주소지"
        case .agent:
            return "주소지"
        }
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Text(titleMessage)
                        .H2()
                        .foregroundColor(.B)
                    Spacer()
                }
                .padding(20)
                
                ScrollView {
                    
                    if formType != .agent {
                        Alert(image: "check", label: alertMessage)
                            .padding([.bottom, .trailing, .leading], 20)
                    }
                    
                    AddressInputField(label: addressInputFieldTitle,
                                      cityAddress: $address.cityAddress,
                                      detailAddress: $address.detailAddress,
                                      isPostCodeViewPresented: $isPostCodeViewPresented)
                    
                }
                if isKeyboardVisible {
                    CTAButton.CustomButtonView(style: .expanded(isDisabled: !isAddressFilled)) {
                        if formType == .patient {
                            showActualAddressCheckView = true
                        } else if formType == .actualPatient {
                            patient.actualAddress = address
                            homeNavigation.navigate(.StepView_Second)
                        } else {
                            agent.address = address
                            homeNavigation.navigate(.SignatureView)
                        }
                    } label: {
                        Text("다음")
                    }
                    .ignoresSafeArea(.keyboard)
                } else {
                    CTAButton.CustomButtonView(style: .primary(isDisabled: !isAddressFilled)) {
                        if formType == .patient {
                            showActualAddressCheckView = true
                        } else if formType == .actualPatient {
                            patient.actualAddress = address
                            homeNavigation.navigate(.StepView_Second)
                        } else {
                            agent.address = address
                            homeNavigation.navigate(.SignatureView)
                        }
                    } label: {
                        Text("다음")
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationDestination(isPresented: $isPostCodeViewPresented) {
                PostCodeInputView(isPostCodeViewPresented: $isPostCodeViewPresented,
                                  cityAddress: $address.cityAddress)
            }
            
            if showActualAddressCheckView {
                Color.black.opacity(0.5).ignoresSafeArea()
            }
        }
        .navigationBarBackButton()
        .sheet(isPresented: $showActualAddressCheckView) {
            VStack(spacing: 0){
                Image("warning")
                    .padding(.top, 34)
                
                Text("작성하신 주민등록지가 현재\n어르신이 머무르고 계신 곳인가요?")
                    .T2()
                    .foregroundColor(.B)
                    .multilineTextAlignment(.center)
                    .padding(20)
                
                Text("어르신이 병원이나 자녀 집 등 다른 곳에 계시다면\n추가 입력이 필요해요.")
                    .Cap3()
                    .foregroundColor(.G5)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                HStack(spacing: 10) {
                    CTAButton.CustomButtonView(style: .secondary) {
                        patient.address = address
                        patient.actualAddress = address
                        hideKeyboard()
                        showActualAddressCheckView = false
                        homeNavigation.navigate(.StepView_Second)
                    } label: {
                        Text("네, 같은 곳이에요")
                    }
                                        
                    CTAButton.CustomButtonView(style: .secondary) {
                        showActualAddressCheckView = false
                        patient.address = address
                        hideKeyboard()
                        homeNavigation.navigate(.AddressFormView_ActualPatient)
                    } label: {
                        Text("아니요, 달라요")
                    }
                }
                .padding(.horizontal)
                .padding(.top, 34)
            }
            .presentationDetents([.fraction(0.43)])
            .presentationDragIndicator(.hidden)
            .presentationCornerRadius(12)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                self.isKeyboardVisible = true
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notification in
                self.isKeyboardVisible = false
            }
        }

    }
    
    enum AddressFormType {
        case patient
        case actualPatient
        case agent
    }
}

struct AddressFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddressFormView(formType: .patient)
            .environmentObject(Patient())
            .environmentObject(Agent())
    }
}
