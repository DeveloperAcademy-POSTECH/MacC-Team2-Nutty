//
//  ApplyTypeView.swift
//  Onbom
//
//  Created by moon on 10/7/23.
//

import SwiftUI


public enum ApplyTypeViewRadioOne: RadioOneProtocol {
    case new, renew, change
    
    var title: String {
        switch(self) {
        case .new: return "신규 신청"
        case .renew: return "갱신"
        case .change: return "등급 변경"
        }
    }
    
    var desc: String {
        switch(self) {
        case .new: return "노인성 질병이 있는 경우에만 신청할 수 있어요"
        case .renew: return "2년에 한 번씩 갱신해 주세요"
        case .change: return "환자의 상태가 변했을 때 신청할 수 있어요"
        }
    }
}

struct ApplyTypeView: View {
    @EnvironmentObject var navigation: NavigationManager
    @State private var isPrivacyPolicyViewPresented = false
    @State private var selected: ApplyTypeViewRadioOne? = nil
    
    var body: some View {
        ZStack {
            VStack {
                Text("장기요양등급\n신청 종류를 선택해 주세요")
                    .H1()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 48)
                
                Button(action: {}, label: {})
                    .buttonStyle(RadioOneButtonStyle(type: .new, selected: $selected, action: showModal))
                Button(action: {}, label: {})
                    .buttonStyle(RadioOneButtonStyle(type: .renew, selected: $selected, disabled: true))
                Button(action: {}, label: {})
                    .buttonStyle(RadioOneButtonStyle(type: .change, selected: $selected, disabled: true))
                Spacer()
            }
            .navigationBarBackButton()
            .padding(20)
            if isPrivacyPolicyViewPresented {
                Color.black.opacity(0.3).ignoresSafeArea()
            }
        }
        .sheet(isPresented: $isPrivacyPolicyViewPresented) {
            PrivacyPolicyView(isPrivacyPolicyViewPresented: $isPrivacyPolicyViewPresented)
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.hidden)
        }
    }
    
    func showModal() {
        isPrivacyPolicyViewPresented = true
    }
}
struct ApplyTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyTypeView()
    }
}


