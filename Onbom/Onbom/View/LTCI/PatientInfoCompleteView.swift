//
//  PatientInfoCompleteView.swift
//  Onbom
//
//  Created by 금가경 on 11/14/23.
//

import SwiftUI

struct PatientInfoCompleteView: View {
    @Binding var isPatientInfoCompleteViewPresented: Bool
    @EnvironmentObject var patient: Patient
    
    var body: some View {
        VStack(spacing: 34) {
            Text("\(patient.name)님의 정보를\n 모두 확인했어요")
                .H1()
            Image("checkmark")
            Spacer()
        }
        .padding(.top, 172.8)
        .navigationBarBackButtonHidden(true)
    }
        
}

#Preview {
    PatientInfoCompleteView(isPatientInfoCompleteViewPresented: .constant(true))
        .environmentObject(mockPatient)
}
