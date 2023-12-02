//
//  RadioButtonStylel.swift
//  Onbom
//
//  Created by moon on 12/1/23.
//

import SwiftUI


protocol RadioOneProtocol: Equatable {
    var title: String { get }
    var desc: String { get }
}

struct RadioOneButtonStyle<T: RadioOneProtocol>: ButtonStyle {
    let type: T
    let disabled: Bool
    let action: (() -> Void)?
    @Binding var selected: T?
    
    init(
        type: T,
        selected: Binding<T?>,
        disabled: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.type = type
        self._selected = selected
        self.disabled = disabled
        self.action = action
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        
        return VStack(alignment: .leading, spacing: 13) {
            Text(type.title)
                .T2()
                .foregroundColor(disabled ? .G3 : titleColor(isPressed))
            Text(type.desc)
                .Cap3()
                .foregroundColor(disabled ? .G3 : descColor(isPressed))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, 16)
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 10).fill(disabled ? .G2 : backgroundColor(isPressed)))
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(disabled ? . G2 : strokeColor(isPressed), lineWidth: 1.2))
        .onTapGesture {
            selected = type
            action?()
        }
        .disabled(disabled)
    }
    
    func titleColor(_ isPressed: Bool) -> Color {
        if(isPressed) { return .Green4 }
        else if(type == selected) { return .Green4 }
        else { return .B }
    }
    func descColor(_ isPressed: Bool) -> Color {
        if(isPressed) { return .Green4 }
        else if(type == selected) { return .Green4 }
        else { return .G5 }
    }
    
    func backgroundColor(_ isPressed: Bool) -> Color {
        if(isPressed) { return .Green3 }
        else if(type == selected) { return .Green2 }
        else { return .G2 }
    }
    
    func strokeColor(_ isPressed: Bool) -> Color {
        if(isPressed) { return .TGreen }
        else if(type == selected) { return .Green4.opacity(0.7) }
        else { return .G2 }
    }
    
}
