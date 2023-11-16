//
//  AgentInfoView.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/09.
//

import SwiftUI

struct AgentInfoView: View {
    // MARK: - 유저 데이터 관련 변수
    @EnvironmentObject var agent: Agent
    @EnvironmentObject var patient: Patient
    
    // MARK: - Navigation 관련 변수
    @EnvironmentObject var navigation: NavigationManager
    
    // MARK: - 라디오버튼 관련 변수
    let relation: [String] = ["가족", "친족"]
    @State private var selectedItem: String = ""
    @State private var detailRelation: String = ""
    @State private var isDisabled = true
    @State private var isKeyboardVisible: Bool = false
    @State private var step: [Bool]
    @State private var didAppear: [Bool]
    let editState: Bool
        
    private var title: String {
        get {
            if(editState) { return "\(agent.name)님과 \(patient.name)님의\n관계를 확인해 주세요" }
            else { return "\(agent.name)님과 \(patient.name)님의\n관계를 선택해 주세요" }
        }
    }

    init(isEdit: Bool = false) {
        self.editState = isEdit
        if(editState) {
            self.step = [true, true]
            self.didAppear = [true, true]
        }
        else {
            self.step = [true, false]
            self.didAppear = [true, false]
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.G1.opacity(0.0001)
                .onTapGesture { hideKeyboard() }
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .H1()
                    .foregroundColor(Color.B)
                    .padding(.top, 24)
                    .padding(.horizontal, 20)
                VStack(spacing: 36) {
                    Spacer().frame(height: 12)
                    if editState {
                        relationField
                        detailRelationField
                    }
                    else {
                        if(step[1]) { detailRelationField }
                        if(step[0]) { relationField }
                    }
                }
                Spacer()
            }
            nextButton
        }
        .navigationBarBackButton()
        .onAppear { self.onAppear() }
    }
}


// MARK: AgentInfoView 함수
extension AgentInfoView {
        
    private func onClickButton() {
        agent.relation = self.selectedItem
        agent.detailRelation = self.detailRelation
        if navigation.isUserFromSubmitCheckListView {
            navigation.pop()
        } else {
            navigation.navigate(.IDCardDescriptionView)
        }
    }
    
    private func didFinishSelectRelation() {
        if(navigation.isUserFromSubmitCheckListView) { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation {
                step[1] = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation {
                didAppear[1] = true
            }
        }
    }
    
    
    private func onAppear() {
        
        if(editState) { loadAgent() }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            self.isKeyboardVisible = true
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notification in
            self.isKeyboardVisible = false
        }
    }
    
    private func loadAgent() {
        selectedItem = agent.relation
        detailRelation = agent.detailRelation
    }
    
    private func isActiveButton() -> Bool {
        if(detailRelation.count > 0) { return true }
        
        return false
    }
}

// MARK: AgentInfoView 컴포넌트
extension AgentInfoView {
    
    private var relationField: some View {
        VStack(spacing: 12){
            Text("관계")
                .Label()
                .foregroundColor(Color.G6)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                ForEach(0..<2, id: \.self) { index in
                    let style: RadioButtonStyle = selectedItem == relation[index] ? .twoSelected : .twoUnselected
                    
                    RadioButton.CustomButtonView(style: style) {
                        selectedItem = relation[index]
                        isDisabled = false
                        didFinishSelectRelation()
                    } label: {
                        Text(relation[index])
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }

        
    private var detailRelationField : some View {
        FormTextField(formSubject: "상세 관계", placeHolder: "예) 자녀, 배우자", textInput: self.$detailRelation, isWrong: .constant(false))
            .animation(.easeInOut, value: step)
            .onSubmit { isKeyboardVisible = false }
            .padding(.horizontal, 20)
            .appear(didAppear[1])
    }

    
    private var nextButton: some View {
        Group {
            if isKeyboardVisible {
                CTAButton.CustomButtonView(style: .expanded(isDisabled: !isActiveButton())) {
                    onClickButton()
                } label: {
                    Text(navigation.isUserFromSubmitCheckListView ? "수정 완료" : "다음")
                }
            }
            else {
                VStack(spacing: 10){
                    Button {
                        navigation.navigate(.AgentInfoDetailView)
                    } label: {
                        Text("상세 관계를 모르겠어요")
                            .Label()
                            .foregroundColor(.G5)
                            .padding(.bottom, 1)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.G4),
                                alignment: .bottom
                            )
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    CTAButton.CustomButtonView(style: .primary(isDisabled: !isActiveButton())) {
                        onClickButton()
                    } label: {
                        Text(navigation.isUserFromSubmitCheckListView ? "수정 완료" : "다음")
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
   
}

struct AgentInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AgentInfoView()
            .environmentObject(mockAgent)
            .environmentObject(mockPatient)
            .environmentObject(NavigationManager())
    }
}
