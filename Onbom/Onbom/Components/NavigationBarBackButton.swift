//
//  NavigationBarBackButton.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/10.
//

import SwiftUI

struct NavigationBarBackButton: View {
    @Environment(\.dismiss) private var dismiss
    var color: Color
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(color)
        }
    }
}

extension View {
    func navigationBarBackButton(color: Color) -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationBarBackButton(color: color)
                }
            }
    }
}
