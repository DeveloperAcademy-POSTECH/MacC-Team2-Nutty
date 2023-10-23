//
//  View+Extension.swift
//  Onbom
//
//  Created by moon on 10/10/23.
//

import SwiftUI

extension View {
    @ViewBuilder
    func isHidden(_ hidden: Bool) -> some View {
        if hidden { self.hidden() }
        else { self }
    }
    
    @ViewBuilder
    func appear(_ appear: Bool) -> some View {
        if appear { self }
        else { self.hidden() }
    }
        
    func ckerning(_ kerning: CGFloat) -> some View {
        modifier(CKerning(kerning: kerning))
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
