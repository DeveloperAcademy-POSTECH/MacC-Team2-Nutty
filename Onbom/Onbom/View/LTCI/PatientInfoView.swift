//
//  PatientInfoView.swift
//  Onbom
//
//  Created by moon on 10/9/23.
//

import SwiftUI
import Combine


struct PatientInfoView: View {
    private enum Field: Hashable {
        case seniorName
        case seniorPhoneNumber
        case seniorIDNumber1
        case seniorIDNumber2
    }
    @EnvironmentObject var patient: Patient
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    
    @State private var step:                    [Bool] = [true, true, false]
    @State private var didAppear:               [Bool] = [true, true, false]
    @State private var isKeyboardVisible:       Bool = true
    @State private var isPressed:               Bool = false
    
    @ObservedObject private var viewModel = PatientInfoViewModel()
    
    @FocusState private var focusedField:       Field?
    
    var body: some View {
        VStack(spacing: 0) {
            Text(step[1] == false ? "어르신의\n성함을 입력해주세요" : viewModel.seniorName + getTitle())
                .H1()
                .foregroundColor(Color.B)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            ScrollView(showsIndicators: false) {
                if(step[2]) {
                    Alert(image: "security", label: "입력한 주민등록번호는 저장되지 않으니 안심하세요")
                        .padding(20)
                        .padding(.bottom, 8)
                        .appear(didAppear[2])
                    
                    VStack(spacing: 8) {
                        Text("주민번호")
                            .foregroundColor(viewModel.isSeniorIDNumber1Wrong ? Color.R : 
                                             focusedField == .seniorIDNumber1 || focusedField == .seniorIDNumber2 ? Color.Green4 : Color.G6)
                            .Label()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 0){
                            ZStack(alignment: .trailing){
                                TextField("앞 6자리", text: $viewModel.seniorIDNumber1)
                                    .font(.custom("Pretendard-Medium", size: 16))
                                    .lineSpacing(16 / 2 * (100 - 100)/100)
                                    .kerning(-3/10)
                                    .foregroundColor(Color.B)
                                    .onReceive(Just(viewModel.seniorIDNumber1)) { _ in
                                        if viewModel.seniorIDNumber1.count > 6 {
                                            viewModel.seniorIDNumber1 = String(viewModel.seniorIDNumber1.prefix(6))
                                        }
                                    }
                                    .onChange(of: viewModel.seniorIDNumber1) { newValue in
                                        if newValue.count == 6 {
                                            focusedField = .seniorIDNumber2
                                        }
                                    }
                                    .focused($focusedField, equals: .seniorIDNumber1)
                                    .keyboardType(.numberPad)
                                    .padding(16)
                                    .background(RoundedRectangle(cornerRadius: 10)
                                        .stroke(viewModel.isSeniorIDNumber1Wrong ? Color.R : 
                                                focusedField == .seniorIDNumber1 ? Color.Green4 : Color.Green1, lineWidth: 1.5))
                                    .tint(Color.Green4)
                                if(viewModel.isSeniorIDNumber1Wrong) {
                                    Image("wrongInputField")
                                        .padding(.trailing, 16)
                                }
                            }
                            Text("-")
                                .padding(.horizontal, 7)
                            
                            SecureField("뒤 7자리", text: $viewModel.seniorIDNumber2)
                                .onReceive(Just(viewModel.seniorIDNumber2)) { _ in
                                    if viewModel.seniorIDNumber2.count > 7 {
                                        viewModel.seniorIDNumber2 = String(viewModel.seniorIDNumber2.prefix(7))
                                    }
                                }
                                .onChange(of: viewModel.seniorIDNumber2) { newValue in
                                    if newValue.count == 7 {
                                        didFinishTypingAll()
                                    }
                                }
                                .focused($focusedField, equals: .seniorIDNumber2)
                                .keyboardType(.numberPad)
                                .padding(16)
                                .background(RoundedRectangle(cornerRadius: 10)
                                    .stroke(focusedField == .seniorIDNumber2 ? Color.Green4 : Color.Green1, lineWidth: 1.5))
                        }
                    }
                    .padding(.horizontal, 20)
                    .appear(didAppear[2])
                }
                if(step[1] == true) {
                    VStack(spacing: 12){
                        FormTextField(formSubject: "전화번호", placeHolder: "전화번호", textInput: $viewModel.seniorPhoneNumber, isWrong: $viewModel.isSeniorPhoneNumberWrong)
                            .onReceive(Just(viewModel.seniorPhoneNumber)) { _ in
                                if viewModel.seniorPhoneNumber.count > 11 {
                                    viewModel.seniorPhoneNumber = String(viewModel.seniorPhoneNumber.prefix(11))
                                }
                            }
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .seniorPhoneNumber)
                            .onSubmit {
                                didFinishTypingName()
                            }
                            .disabled(!viewModel.hasMobile)
                        HStack(spacing: 0){
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(viewModel.hasMobile ? Color.G3 : Color.Green4)
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            Text("전화번호가 없어요")
                                .Cap2()
                                .foregroundColor(.B)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onTapGesture {
                            if(viewModel.hasMobile) {
                                // 핸드폰이 없다고 체크함
                                viewModel.seniorPhoneNumber = ""
                                didFinishTypingPhoneNumber()
                            } else {
                                // 핸드폰이 있다고 체크함
                                focusedField = .seniorPhoneNumber
                            }
                            viewModel.hasMobile.toggle()
                        }
                    }
                    .padding(.top, 36)
                    .padding(.horizontal, 20)
                    .animation(.easeInOut, value: step)
                    .appear(didAppear[1])
                }
                FormTextField(formSubject: "어르신 성함", placeHolder: "성함", textInput: $viewModel.seniorName, isWrong: $viewModel.isSeniorNameWrong)
                    .onReceive(Just(viewModel.seniorName)) { _ in
                        if viewModel.seniorName.count > 6 {
                            viewModel.seniorName = String(viewModel.seniorName.prefix(6))
                        }
                    }
                    .animation(.easeInOut, value: step)
                    .focused($focusedField, equals: .seniorName)
                    .onSubmit {
                        if(viewModel.seniorName.isEmpty) { return }
                        didFinishTypingName()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 36)
                    .padding(.bottom, 120)
                    .background(.red.opacity(0.4))
            }
            if isKeyboardVisible {
                CTAButton.CustomButtonView(style: .expanded(isDisabled: !isActiveButton())) {
                    onClickButton()
                } label: {
                    Text("다음")
                }
                    .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            else {
                CTAButton.CustomButtonView(style: .primary(isDisabled: !isActiveButton())) {
                    onClickButton()
                } label: {
                    Text("다음")
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .padding(.horizontal, 20)
            }
        }
        .padding(.top, 20)
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                self.isKeyboardVisible = true
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notification in
                self.isKeyboardVisible = false
            }
        }
        .navigationBarBackButton()
        .onAppear {
            focusedField = .seniorName
        }
    }
    
    private func isActiveButton() -> Bool {
        return (!step[2] && viewModel.seniorPhoneNumber.count == 11) || (!step[1] && viewModel.seniorName.count > 0) || viewModel.formIsValid
    }
    
    private func onClickButton() {
        if(!step[1]) {
            #if RELEASE
            if(!viewModel.validateName()) { return }
            #endif
            didFinishTypingName()
        } else if(!step[2]) {
            #if RELEASE
            if(!viewModel.validatePhoneNumber()) { return }
            #endif
            didFinishTypingPhoneNumber()
        } else {
            #if RELEASE
            if(!viewModel.validateInputField()) { return }
            #endif
            patient.name = viewModel.seniorName;
            patient.combineID(frontID: viewModel.seniorIDNumber1, backID: viewModel.seniorIDNumber2)
            homeNavigation.navigate(.AddressFormView_Patient)
        }
    }
    
    private func getTitle() -> String {
        if(step[2] == true){
            return "님의\n주민등록번호를 입력해 주세요"
        } else if(step[1] == true) {
            return "님의\n전화번호를 입력해 주세요"
        }
        return ""
    }
    
    
    private func didFinishTypingName() {
        step[1] = true
        focusedField = .seniorPhoneNumber
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation {
                didAppear[1] = true
            }
        }
    }
    
    private func didFinishTypingPhoneNumber() {
        if(step[2] == false) {
            focusedField = .seniorIDNumber1
        }
        step[2] = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation {
                didAppear[2] = true
            }
        }
    }
    
    private func didFinishTypingAll() {
        focusedField = nil
    }
}
