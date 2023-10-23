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

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

