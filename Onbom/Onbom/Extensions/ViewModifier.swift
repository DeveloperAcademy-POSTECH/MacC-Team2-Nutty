//
//  ViewModifier.swift
//  Onbom
//
//  Created by moon on 10/10/23.
//

import SwiftUI

struct CKerning: ViewModifier {
    let kerning: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 1000)
            .kerning(kerning)
            .drawingGroup()
            .padding(.horizontal, -1000)
    }
}
