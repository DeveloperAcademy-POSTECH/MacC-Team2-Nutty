//
//  IDCardConfirmEditView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/15.
//

import SwiftUI

struct IDCardConfirmEditView: View {
    // MARK: - 값 입력 관련 변수
    @State private var frontIDNumber = ""
    @State private var backIDNumber = ""
    @State private var isKeyboardVisible = false
    
    // MARK: - 유저 정보 관련 변수
    @EnvironmentObject var agent: Agent
    
    // MARK: - Navigation 관련 변수
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var navigation: NavigationManager
    
    // MARK: - Dynamic Type 관련 변수
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var isIDNumberValid: Bool {
        frontIDNumber.isValidDateOfBirth() && backIDNumber.isValidIDBackNumber()
    }
    
    var body: some View {
        let dynamicHStack = dynamicTypeSize <= .xxxLarge ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
        
        VStack(spacing: 0) {
            HStack {
                Text("신분증 정보를 확인해 주세요")
                    .H1()
                    .foregroundColor(.B)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Alert(image: "security",
                  label: "신분증 정보는 저장되지 않고, 신청 즉시 파기돼요")
            .padding(.horizontal, 20)
            
            ScrollView {
                ScrollViewReader { proxy in
                    VStack {
                        Image(uiImage: agent.idCardImage)
                            .resizable()
                            .scaledToFit()
                            .padding(.top, 32)
                            .padding(.bottom, 36)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                        IDNumberInputField(frontNumber: $frontIDNumber, backNumber: $backIDNumber)
                            .onAppear {
                                let splittedID = agent.splitID()
                                frontIDNumber = splittedID.frontID
                                backIDNumber = splittedID.backID
                            }
                        Color.clear
                            .frame(height: 30)
                            .id("bottom")
                    }
                    .onChange(of: isKeyboardVisible) { _ in
                        DispatchQueue.main.asyncAfter (deadline: .now() + 0.5) {
                            withAnimation {
                                proxy.scrollTo("bottom", anchor: .bottom)
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            if !isKeyboardVisible {
                dynamicHStack {
                    CTAButton.CustomButtonView(style: .secondary) {
                        dismiss()
                    } label: {
                        Text("재촬영")
                    }
                    .frame(maxWidth: dynamicTypeSize <= .xxxLarge ? 103 : .infinity)
                    
                    CTAButton.CustomButtonView(style: .primary(isDisabled: !isIDNumberValid)) {
                        agent.combineID(frontID: frontIDNumber, backID: backIDNumber)
                        navigation.navigate(.AddressFormView_Agent)
                    } label: {
                        Text("다음")
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.top, 4)
                .padding(.horizontal, 20)
            }
        }
        .padding(.top, 20)
        .navigationBarBackButton()
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
}

struct IDCardConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        IDCardConfirmEditView()
            .environmentObject(Agent())
    }
}

