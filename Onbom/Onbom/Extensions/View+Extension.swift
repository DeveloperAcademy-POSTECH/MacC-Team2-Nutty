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
    
    func ckerning(_ kerning: CGFloat) -> some View {
        modifier(CKerning(kerning: kerning))
    }
}
