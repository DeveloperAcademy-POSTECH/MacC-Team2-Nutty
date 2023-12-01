//
//  NotificationView.swift
//  Onbom
//
//  Created by 금가경 on 11/22/23.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        VStack {
            HStack {
                Text("알림")
                    .H1()
                    .foregroundStyle(Color.B)
                    .padding(.bottom, 192)
                    .padding(.top, 24)
                Spacer()
            }
            VStack {
                Image("trash")
                    .padding(.bottom, 12)
                Text("최근 30일동안 받은 알림이 없어요")
                    .B3()
                    .foregroundStyle(Color.G4)
            }
            .padding(.bottom, 341)
        }
        .navigationBarBackButton()
        .padding(.horizontal, 20)
    }
}

#Preview {
    NotificationView()
}
