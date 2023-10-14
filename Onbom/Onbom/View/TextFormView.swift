//
//  TextFormView.swift
//  Onbom
//
//  Created by moon on 10/10/23.
//

import SwiftUI

struct TextFormView<Content : View> : View {
    @State var validationSeeds : [Bool] = []
    @ViewBuilder var content : (( @escaping () -> Bool)) -> Content
    
    var body: some View {
        content(validate)
            .onPreferenceChange(ValidationPreferenceKey.self) { value in
                validationSeeds = value
            }
    }
    
    private func validate() -> Bool {
        for seed in validationSeeds {
            if !seed { return false }
        }
        return true
    }
}

#Preview {
    TextFormView(){ _ in }
}
