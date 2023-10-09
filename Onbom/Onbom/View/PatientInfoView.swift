//
//  PatientInfoView.swift
//  Onbom
//
//  Created by moon on 10/9/23.
//

import SwiftUI


struct PatientInfoView: View {
    private enum Field: Hashable {
        case seniorName
        case seniorPhoneNumber
        case seniorSSN1
        case seniorSSN2
    }
    
    @State private var hasMobile:               Bool = true
    
    @State private var seniorSSN1:              String = ""
    @State private var seniorSSN2:              String = ""
    @State private var seniorPhoneNumber:       String = ""
    @State private var seniorName:              String = ""
    
    @FocusState private var focusedField:       Field?
    
    var body: some View {
        VStack(spacing: 0) {
            Text("김순옥님의\n정보를 입력해주세요")
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
                ScrollView {
                        HStack(spacing: 0){
                            FormTextField("주민번호", "앞 6자리", textInput: $seniorSSN1)
                                .onChange(of: seniorSSN1) { newValue in
                                    if newValue.count >= 6 {
                                        focusedField = .seniorSSN2
                                    }
                                }
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: .seniorSSN1)
                            Text("-")
                                .padding(.top, 30)
                                .padding(.horizontal, 7)
                            
                            VStack(spacing: 10) {
                                Text("")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                SecureField("뒤 7자리", text: $seniorSSN2)
                                    .onChange(of: seniorSSN2) { newValue in
                                        if newValue.count >= 7 {
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
                        VStack(spacing: 12){
                            FormTextField("전화번호", "전화번호", textInput: $seniorPhoneNumber)
                                .onChange(of: seniorPhoneNumber) { newValue in
                                    if newValue.count >= 11 {
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
                    FormTextField("어르신 성함", "성함", textInput: $seniorName)
                        .focused($focusedField, equals: .seniorName)
                        .onSubmit {
                            if(seniorName.isEmpty) { return }
                            didFinishTypingName()
                        }
                }
                .padding(.horizontal, 20)
                .scrollDismissesKeyboard(.immediately)
                
                Button{
                    Text("다음")
                        .foregroundColor(.white)
                        .padding(20)
                }
                .frame(maxWidth: .infinity)
                .background(validate() ? Color.PB4 : Color.PB3)
        }
        .onAppear {
            focusedField = .seniorName
        }
    }
    

#Preview {
    PatientInfoView()
}
