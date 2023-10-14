//
//  MediHistoryView.swift
//  Onbom
//
//  Created by moon on 10/8/23.
//

import SwiftUI

struct MediHistoryView: View {
    @Binding var navigationPath: [Int]
    
    var body: some View {
        VStack(spacing: 0) {
            Text("김순옥님께서 3개월 내\n입원·수술 이력이 있으신가요?")
                .foregroundColor(Color.B)
                .H2()
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Rectangle()
                .fill(Color.G2)
                .frame(maxHeight: 270)
                .padding(30)
            Spacer()
            
            Button {
                navigationPath.append(3)
            } label: {
                Text("아니요, 없어요")
                    .foregroundColor(Color.white)
                    .B1()
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
            }
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.PB4))
            .padding(.bottom, 10)
            
            Button {
                navigationPath.append(3)
            } label: {
                Text("입원 또는 수술 이력이 있어요")
                    .foregroundColor(Color.PB4)
                    .B1()
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
            }
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.PB2))
        }
        .padding(20)
    }
}

#Preview {
    MediHistoryView(navigationPath: .constant([]))
}
