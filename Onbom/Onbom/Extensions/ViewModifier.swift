//
//  ViewModifier.swift
//  Onbom
//
//  Created by moon on 10/10/23.
//

import SwiftUI

struct ValidationModifier : ViewModifier {
    let validation : () -> Bool
    
    func body(content: Content) -> some View {
        content
            .preference(
                key: ValidationPreferenceKey.self,
                value: [validation()]
            )
    }
}
