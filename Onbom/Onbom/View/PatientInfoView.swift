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
        case seniorSSN1
        case seniorSSN2
    }
    @Binding var path: [Int]
    
    @State private var step:                    [Bool] = [true, false, false]
    @State private var didAppear:               [Bool] = [true, false, false]
    @State private var hasMobile:               Bool = true
    
    @State private var seniorSSN1:              String = ""
    @State private var seniorSSN2:              String = ""
    @State private var seniorPhoneNumber:       String = ""
    @State private var seniorName:              String = ""
    
    @FocusState private var focusedField:       Field?
    
    var body: some View {
        VStack(spacing: 0) {
            Text(step[1] == false ? "어르신의\n성함을 입력해주세요" : seniorName + getTitle())
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

            TextFormView { validate in
                ScrollView {
                    if(step[2]) {
                        VStack(spacing: 10) {
                            Text("주민번호")
                                .foregroundColor(focusedField == .seniorSSN1 || focusedField == .seniorSSN2 ? Color.PB4 : Color.G6)
                                .Label()
                                .frame(maxWidth: .infinity, alignment: .leading)

                            HStack(spacing: 0){
                                TextField("앞 6자리", text: $seniorSSN1)
                                    .validate{
                                        seniorSSN1.count == 6
                                    }
                                    .onReceive(Just(seniorSSN1)) { _ in
                                        if seniorSSN1.count > 6 {
                                            seniorSSN1 = String(seniorSSN1.prefix(6))
                                        }
                                    }
                                    .onChange(of: seniorSSN1) { newValue in
                                        if newValue.count == 6 {
                                            focusedField = .seniorSSN2
                                        }
                                    }
                                    .focused($focusedField, equals: .seniorSSN1)
                                    .keyboardType(.numberPad)
                                    .padding(16)
                                    .background(RoundedRectangle(cornerRadius: 10)
                                        .stroke(focusedField == .seniorSSN1 ? Color.PB4 : Color.PB1, lineWidth: 1.5))
                                    .tint(Color.PB4)
                                Text("-")
                                    .padding(.horizontal, 7)
                                
                                SecureField("뒤 7자리", text: $seniorSSN2)
                                    .validate {
                                        seniorSSN2.count == 7
                                    }
                                    .onReceive(Just(seniorSSN2)) { _ in
                                        if seniorSSN2.count > 7 {
                                            seniorSSN2 = String(seniorSSN2.prefix(7))
                                        }
                                    }
                                    .onChange(of: seniorSSN2) { newValue in
                                        if newValue.count == 7 {
                                            didFinishTypingAll()
                                        }
                                    }
                                    .focused($focusedField, equals: .seniorSSN2)
                                    .keyboardType(.numberPad)
                                    .padding(16)
                                    .background(RoundedRectangle(cornerRadius: 10)
                                        .stroke(focusedField == .seniorSSN2 ? Color.PB4 : Color.PB1, lineWidth: 1.5))
                            }
                        }
                        .padding(.bottom, 36)
                        .appear(didAppear[2])
                    }
                    if(step[1] == true) {
                        VStack(spacing: 12){
                            FormTextField(formSubject: "전화번호", placeHolder: "전화번호", textInput: $seniorPhoneNumber)
                                .validate{
                                    seniorPhoneNumber.count == 11 || !hasMobile
                                }
                                .onReceive(Just(seniorPhoneNumber)) { _ in
                                    if seniorPhoneNumber.count > 11 {
                                        seniorPhoneNumber = String(seniorPhoneNumber.prefix(11))
                                    }
                                }
                                .onChange(of: seniorPhoneNumber) { newValue in
                                    if newValue.count == 11 {
                                        didFinishTypingPhoneNumber()
                                    }
                                }
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: .seniorPhoneNumber)
                                .onSubmit {
                                    didFinishTypingName()
                                }
                                .disabled(!hasMobile)
                            HStack(spacing: 0){
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(hasMobile ? Color.G3 : Color.PB4)
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 10)
                                Text("전화번호가 없어요")
                                    .Cap2()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onTapGesture {
                                if(hasMobile) {
                                    // 핸드폰이 없다고 체크함
                                    self.seniorPhoneNumber = ""
                                    didFinishTypingPhoneNumber()
                                } else {
                                    // 핸드폰이 있다고 체크함
                                    focusedField = .seniorPhoneNumber
                                }
                                hasMobile.toggle()
                            }
                        }
                        .padding(.bottom, 36)
                        .animation(.easeInOut, value: step)
                        .appear(didAppear[1])
                    }
                    FormTextField(formSubject: "어르신 성함", placeHolder: "성함", textInput: $seniorName)
                        .validate{
                            !seniorName.isEmpty && step[2] == true
                        }
                        .onReceive(Just(seniorName)) { _ in
                            if seniorName.count > 6 {
                                seniorName = String(seniorName.prefix(6))
                            }
                        }
                        .animation(.easeInOut, value: step)
                        .focused($focusedField, equals: .seniorName)
                        .onSubmit {
                            if(seniorName.isEmpty) { return }
                            didFinishTypingName()
                        }
                }
                .padding(.horizontal, 20)
                .scrollDismissesKeyboard(.immediately)
                
                Button{
                } label: {
                    Text("다음")
                        .foregroundColor(.white)
                        .padding(20)
                }
                .frame(maxWidth: .infinity)
                .background(validate() ? Color.PB4 : Color.PB3)
                .disabled(!validate())
            }
        }
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
        focusedField = .seniorSSN1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            didAppear[2] = true
        }
    }
    
    private func didFinishTypingAll() {
        focusedField = nil
    }
}

#Preview {
    PatientInfoView(path: .constant([]))
}
