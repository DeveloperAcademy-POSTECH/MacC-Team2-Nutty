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
    @EnvironmentObject var patient: Patient
    @EnvironmentObject var agent: Agent
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    
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
    
    var body: some View {
        ZStack {
            VStack {
                Group {
                    HStack {
                        Text(titleMessage)
                            .H2()
                            .foregroundColor(.B)
                        Spacer()
                    }
                    .padding()
                    if formType != .agent {
                        HStack(spacing: 4) {
                            alertImage
                                .padding(.leading, 13)
                                .foregroundColor(.PB4)
                            Text(alertMessage)
                                .foregroundColor(Color.G6)
                                .Cap4()
                                .padding(.vertical)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.PB1))
                        .padding()
                        .padding(.bottom)
                    }
                }
                
                AddressInputField(label: "현재 살고 계신 주소지",
                                  cityAddress: $address.cityAddress,
                                  detailAddress: $address.detailAddress,
                                  isPostCodeViewPresented: $isPostCodeViewPresented)
                
                Spacer()
                
                //CTA Button
                Button {
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
                        .foregroundColor(Color.white)
                        .B1()
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                }
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.PB4))
                .padding(.bottom, 10)
                .padding()
                .navigationDestination(isPresented: $isPostCodeViewPresented) {
                    PostCodeInputView(isPostCodeViewPresented: $isPostCodeViewPresented,
                                      cityAddress: $address.cityAddress)
                }
            }
            if showActualAddressCheckView {
                Color.black.opacity(0.5).ignoresSafeArea()
            }
        }
        .navigationBarBackButton()
        .sheet(isPresented: $showActualAddressCheckView) {
            VStack{
                Rectangle().frame(width: 70, height: 70).foregroundColor(.gray)
                
                Text("작성하신 주민등록지가 현재\n어르신이 머무르고 계신 곳인가요?")
                    .T2()
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("어르신이 병원이나 자녀 집 등 다른 곳에 계시다면\n추가 입력이 필요해요.")
                    .Cap2()
                    .multilineTextAlignment(.center)
                
                HStack {
                    Button {
                        showActualAddressCheckView.toggle()
                    } label: {
                        Text("아니오 달라요")
                            .B1()
                            .foregroundColor(.PB4)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.PB2))
                    
                    Spacer()
                    Button {
                        patient.address = address
                        showActualAddressCheckView = false
                        homeNavigation.navigate(.AddressFormView_ActualPatient)
                    } label: {
                        Text("네, 같은 곳이에요")
                            .B1()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.PB4))
                    
                }
                .padding(.horizontal)
                .padding(.top)
            }
            .presentationDetents([.height(300)])
            .presentationDragIndicator(.hidden)
            .presentationCornerRadius(12)
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
