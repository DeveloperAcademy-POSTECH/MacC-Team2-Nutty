//
//  ToastAlert.swift
//  Onbom
//
//  Created by Junyoo on 11/22/23.
//

import SwiftUI

struct ToastAlertView: View {
    var warningMessage: String
    
    var body: some View {
        HStack(spacing: 0) {
            Image("warning-rounded")
                .frame(width: 24, height: 24)
                .padding(.leading, 10)
                .padding(.trailing, 12)
            Text(warningMessage)
                .B2()
                .foregroundStyle(Color.W)
                .padding(.trailing, 10)
        }
        .padding(14)
        .background {
            RoundedRectangle(cornerRadius: 40)
                .foregroundStyle(Color(red: 0.4, green: 0.46, blue: 0.44).opacity(0.85))
        }
        .shadow(color: .black.opacity(0.03), radius: 8, x: 0, y: 4)
    }
}

struct ToastAlert: Equatable {
    var message: String
    var duration: Double = 2.5
}

#Preview {
    ToastAlertView(warningMessage: "지금은 서비스 준비중이에요")
}
