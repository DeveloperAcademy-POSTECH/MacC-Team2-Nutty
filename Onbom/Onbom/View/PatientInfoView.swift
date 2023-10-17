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
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    
    @State private var step:                    [Bool] = [true, false, false]
    @State private var didAppear:               [Bool] = [true, false, false]
    
    @ObservedObject private var viewModel = PatientInfoViewModel()
    
    @FocusState private var focusedField:       Field?
    
    var body: some View {
        VStack(spacing: 0) {
            Text(step[1] == false ? "어르신의\n성함을 입력해주세요" : viewModel.seniorName + getTitle())
                .H2()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            HStack(spacing: 4) {
                Image("security")
                    .padding(.leading, 13)
                Text("입력한 주민등록번호는 저장되지 않으니 안심하세요")
                    .foregroundColor(Color.G6)
                    .Cap4()
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.PB1))
            .padding(20)
            .appear(didAppear[2])
            
            ScrollView {
                if(step[2]) {
                    VStack(spacing: 10) {
                        Text("주민번호")
                            .foregroundColor(focusedField == .seniorIDNumber1 || focusedField == .seniorIDNumber2 ? Color.PB4 : Color.G6)
                            .Label()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 0){
                            TextField("앞 6자리", text: $viewModel.seniorIDNumber1)
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
                                    .stroke(focusedField == .seniorIDNumber1 ? Color.PB4 : Color.PB1, lineWidth: 1.5))
                                .tint(Color.PB4)
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
                                    .stroke(focusedField == .seniorIDNumber2 ? Color.PB4 : Color.PB1, lineWidth: 1.5))
                        }
                    }
                    .padding(.bottom, 36)
                    .appear(didAppear[2])
                }
                if(step[1] == true) {
                    VStack(spacing: 12){
                        FormTextField(formSubject: "전화번호", placeHolder: "전화번호", textInput: $viewModel.seniorPhoneNumber)
                            .onReceive(Just(viewModel.seniorPhoneNumber)) { _ in
                                if viewModel.seniorPhoneNumber.count > 11 {
                                    viewModel.seniorPhoneNumber = String(viewModel.seniorPhoneNumber.prefix(11))
                                }
                            }
                            .onChange(of: viewModel.seniorPhoneNumber) { newValue in
                                if newValue.count == 11 {
                                    didFinishTypingPhoneNumber()
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
                                .foregroundColor(viewModel.hasMobile ? Color.G3 : Color.PB4)
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            Text("전화번호가 없어요")
                                .Cap2()
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
                    .padding(.bottom, 36)
                    .animation(.easeInOut, value: step)
                    .appear(didAppear[1])
                }
                FormTextField(formSubject: "어르신 성함", placeHolder: "성함", textInput: $viewModel.seniorName)
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
            }
            .padding(.horizontal, 20)
            .scrollDismissesKeyboard(.immediately)
            
            Button{
                homeNavigation.navigate(.AddressFormView_Patient)
            } label: {
                Text("다음")
                    .foregroundColor(.white)
                    .padding(20)
            }
            .frame(maxWidth: .infinity)
            .background(viewModel.formIsValid ? Color.PB4 : Color.PB3)
            .disabled(!viewModel.formIsValid)
        }
        .navigationBarBackButton()
        .onAppear {
            focusedField = .seniorName
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
            didAppear[1] = true
        }
    }
    
    private func didFinishTypingPhoneNumber() {
        step[2] = true
        focusedField = .seniorIDNumber1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            didAppear[2] = true
        }
    }
    
    private func didFinishTypingAll() {
        focusedField = nil
    }
}

