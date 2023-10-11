//
//  AddressFormView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/10.
//

import SwiftUI

struct AddressFormView: View {
    @State private var cityAddress = ""
    @State private var detailAddress = ""
    @State private var isPostCodeViewPresented = false
    @State private var showActualAddressCheckView = false
    @EnvironmentObject var application: ApplicationViewModel

    @Binding var path: [Int]

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Group {
                        HStack {
                            Text("\(application.patientName)님이 현재 살고 계신\n주소지를 입력해 주세요")
                                .H2()
                                .foregroundColor(.B)
                            Spacer()
                        }
                        .padding()
                        
                        Text("방문조사와 우편물 수령을 위한 주소가 필요해요")
                        .padding()
                        .padding(.bottom)
                    }

                    AddressInputField(label: "현재 살고 계신 주소지",
                                      cityAddress: $application.patientActualAddress.cityAddress,
                                      detailAddress: $application.patientActualAddress.detailAddress, isPostCodeViewPresented: $isPostCodeViewPresented)
                    
                    Spacer()
                    
                    //CTA Button
                    Button {
                        showActualAddressCheckView = true
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
                                          cityAddress: $application.patientActualAddress.cityAddress)
                    }
                }
                if showActualAddressCheckView {
                    Color.black.opacity(0.5).ignoresSafeArea()
                }
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
                        showActualAddressCheckView.toggle()
//                        path.append()
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
}

struct AddressFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddressFormView(path: .constant([]))
            .environmentObject(ApplicationViewModel())
    }
}