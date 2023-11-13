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
    public enum PatientInfoViewEditState {
        case editPhoneNumber
        case editIDNumber
    }
    let editState: PatientInfoViewEditState?
    
    @EnvironmentObject var patient: Patient
    @EnvironmentObject var navigation: NavigationManager
    
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @State private var idNumberFront: String = ""
    @State private var idNumberBack: String = ""
    
    @State private var hasMobile: Bool = true
    
    @State private var isSeniorNameWrong:       Bool = false
    @State private var isSeniorPhoneNumberWrong:Bool = false
    @State private var isSeniorIDNumber1Wrong:  Bool = false
    
    @State private var step: [Bool]
    @State private var didAppear: [Bool]
    @State private var isKeyboardVisible: Bool = true
    
    @FocusState private var focusedField: Field?
    
    init(editState: PatientInfoViewEditState? = nil) {
        self.editState = editState
        
        switch(editState) {
        case .editPhoneNumber:
            self.didAppear = [false, true, false]
            self.step = [false, true, false]
        case .editIDNumber:
            self.didAppear = [false, false, true]
            self.step = [false, false, true]
        case .none:
            self.didAppear = [true, false, false]
            self.step = [true, false, false]
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            header
            
            ScrollView(showsIndicators: false) {
                if(step[2]) { idNumberField }
                if(step[1]) { phoneNumberField }
                if(step[0]) { nameField }
            }
            
            nextButton
        }
        .onAppear { self.onAppear() }
        .onTapGesture { hideKeyboard() }
        .navigationBarBackButton()
    }
    
    private func onAppear() {
        loadPatientInfo()
        focusedField = .seniorName
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            self.isKeyboardVisible = true
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notification in
            self.isKeyboardVisible = false
        }
    }
    
    private func loadPatientInfo() {
        let idNumber = self.patient.id
        
        self.name = patient.name
        self.phoneNumber = patient.phoneNumber
        self.idNumberFront = String(idNumber.prefix(6))
        self.idNumberBack = String(idNumber.suffix(7))
    }
    
    private func isActiveButton() -> Bool {
        if let editState = self.editState {
            if editState == .editIDNumber {
                if idNumberFront.count == 6 && idNumberBack.count == 7 {
                    return true
                }
            }
            else if editState == .editPhoneNumber {
                if phoneNumber.count == 11 {
                    return true
                }
            }
            return false
        }
        
        if !step[1] {
            if name.count > 0 { return true }
        } else if !step[2] {
            if phoneNumber.count == 11 { return true }
        } else {
            if name.count > 0 &&
                (phoneNumber.count == 11 || !hasMobile) &&
                idNumberFront.count == 6 &&
                idNumberBack.count == 7 {
                return true
            }
        }
        
        return false
    }
    
    private func onClickButton() {
        
        if editComplete() { return }
        
        if(!step[1]) {
            isSeniorNameWrong = !name.isValidName()
            if(isSeniorNameWrong == true) { return }
            
            didFinishTypingName()
        } else if(!step[2]) {
            isSeniorNameWrong = !name.isValidName()
            isSeniorPhoneNumberWrong = !phoneNumber.isValidPhoneNumber()
            
            if(isSeniorNameWrong == true) { return }
            if(isSeniorPhoneNumberWrong == true) { return }
            
            didFinishTypingPhoneNumber()
        } else {
            isSeniorNameWrong = !name.isValidName()
            isSeniorPhoneNumberWrong = !phoneNumber.isValidPhoneNumber()
            isSeniorIDNumber1Wrong = !idNumberFront.isValidDateOfBirth()
            
            if(!hasMobile) { isSeniorPhoneNumberWrong = false }
            if(isSeniorNameWrong == true) { return }
            if(isSeniorPhoneNumberWrong == true) { return }
            if(isSeniorIDNumber1Wrong == true) { return }
            
            patient.name = self.name
            patient.combineID(frontID: self.idNumberFront, backID: self.idNumberBack)
            patient.phoneNumber = self.phoneNumber
            navigation.navigate(.AddressFormView_Patient)
        }
    }
    
    private func editComplete() -> Bool {
        guard let isEditMode = self.editState else { return false }
        
        switch(isEditMode) {
        case .editPhoneNumber:
            isSeniorPhoneNumberWrong = !phoneNumber.isValidPhoneNumber()
            if(isSeniorPhoneNumberWrong == false) {
                patient.phoneNumber = phoneNumber
                navigation.pop()
            }
        case .editIDNumber:
            isSeniorIDNumber1Wrong = !idNumberFront.isValidDateOfBirth()
            if(isSeniorIDNumber1Wrong == false) {
                patient.combineID(frontID: self.idNumberFront, backID: self.idNumberBack)
                navigation.pop()
            }
        }
        
        return true
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


extension PatientInfoView {
    private var header: some View {
        VStack(spacing: 0) {
            Text(step[1] == false ? "어르신의\n성함을 입력해주세요" : name + getTitle())
                .H1()
                .foregroundColor(Color.B)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 20)
            
            if(step[2]) {
                Alert(image: "security", label: "입력한 주민등록번호는 저장되지 않으니 안심하세요")
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                    .padding(.top, 20)
                    .appear(didAppear[2])
            }
        }
    }
    
    private var nameField : some View {
        FormTextField(formSubject: "어르신 성함", placeHolder: "성함", textInput: self.$name, isWrong: $isSeniorNameWrong)
            .onReceive(Just(name)) { _ in
                if name.count > 6 {
                    name = String(name.prefix(6))
                }
            }
            .animation(.easeInOut, value: step)
            .focused($focusedField, equals: .seniorName)
            .onSubmit {
                if(name.isEmpty) { return }
                didFinishTypingName()
            }
            .padding(.horizontal, 20)
            .padding(.top, 36)
            .padding(.bottom, 60)
    }
    
    private var phoneNumberField: some View {
        VStack(spacing: 12){
            FormTextField(formSubject: "전화번호", placeHolder: "전화번호", textInput: self.$phoneNumber, isWrong: $isSeniorPhoneNumberWrong)
                .onReceive(Just(self.phoneNumber)) { _ in
                    if self.phoneNumber.count > 11 {
                         self.phoneNumber = String(self.phoneNumber.prefix(11))
                    } else if self.phoneNumber.count < 11 {
                        isSeniorPhoneNumberWrong = false
                    }
                }
                .keyboardType(.numberPad)
                .focused($focusedField, equals: .seniorPhoneNumber)
                .onSubmit {
                    didFinishTypingName()
                }
                .disabled(!self.hasMobile)
            if self.editState == nil {
                HStack(spacing: 0){
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor( hasMobile ? Color.G3 : Color.Green4)
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 10)
                    Text("전화번호가 없어요")
                        .Cap2()
                        .foregroundColor(.B)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    if(hasMobile) {
                        // 핸드폰이 없다고 체크함
                        self.phoneNumber = ""
                        isSeniorPhoneNumberWrong = false
                        didFinishTypingPhoneNumber()
                    } else {
                        // 핸드폰이 있다고 체크함
                        focusedField = .seniorPhoneNumber
                    }
                    hasMobile.toggle()
                }
            }
        }
        .padding(.top, 36)
        .padding(.horizontal, 20)
        .animation(.easeInOut, value: step)
        .appear(didAppear[1])
    }
    
    private var idNumberField: some View {
        VStack(spacing: 8) {
            Text("주민번호")
                .foregroundColor( isSeniorIDNumber1Wrong ? Color.R :
                                    focusedField == .seniorIDNumber1 || focusedField == .seniorIDNumber2 ? Color.Green4 : Color.G6)
                .Label()
                .padding(.top, 32)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 0){
                ZStack(alignment: .trailing){
                    TextField("앞 6자리", text: self.$idNumberFront)
                        .font(.custom("Pretendard-Medium", size: 16))
                        .lineSpacing(16 / 2 * (100 - 100)/100)
                        .kerning(-3/10)
                        .foregroundColor(Color.B)
                        .onReceive(Just(self.idNumberFront)) { _ in
                            if self.idNumberFront.count > 6 {
                                 self.idNumberFront = String(self.idNumberFront.prefix(6))
                            } else if self.idNumberFront.count < 6 {
                                isSeniorIDNumber1Wrong = false
                            }
                        }
                        .onChange(of: self.idNumberFront) { newValue in
                            if newValue.count == 6 {
                                focusedField = .seniorIDNumber2
                            }
                        }
                        .focused($focusedField, equals: .seniorIDNumber1)
                        .keyboardType(.numberPad)
                        .padding(16)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke( isSeniorIDNumber1Wrong ? Color.R :
                                        focusedField == .seniorIDNumber1 ? Color.Green4 : Color.Green1, lineWidth: 1.5))
                        .tint(Color.Green4)
                    if( isSeniorIDNumber1Wrong) {
                        Image("wrongInputField")
                            .padding(.trailing, 16)
                    }
                }
                Text("-")
                    .padding(.horizontal, 7)
                
                SecureField("뒤 7자리", text: self.$idNumberBack)
                    .frame(height:23)
                    .font(.system(size: 16))
                    .onReceive(Just( self.idNumberBack)) { _ in
                        if  self.idNumberBack.count > 7 {
                             self.idNumberBack = String( self.idNumberBack.prefix(7))
                        }
                    }
                    .onChange(of:  self.idNumberBack) { newValue in
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
    
    private var nextButton: some View {
        Group {
            if isKeyboardVisible {
                CTAButton.CustomButtonView(style: .expanded(isDisabled: !isActiveButton())) {
                    onClickButton()
                } label: {
                    Text(navigation.isUserFromSubmitCheckListView ? "수정완료" : "다음")
                }
            }
            else {
                CTAButton.CustomButtonView(style: .primary(isDisabled: !isActiveButton())) {
                    onClickButton()
                } label: {
                    Text(navigation.isUserFromSubmitCheckListView ? "수정완료" : "다음")
                }
                .padding(.horizontal, 20)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
#Preview {
    PatientInfoView()
        .environmentObject(Patient())
}
