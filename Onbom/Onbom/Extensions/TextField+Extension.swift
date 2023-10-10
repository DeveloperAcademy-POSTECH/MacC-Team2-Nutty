//
//  TextField+Extension.swift
//  Onbom
//
//  Created by moon on 10/10/23.
//

import SwiftUI

extension TextField {
    func validate(_ flag : @escaping ()-> Bool) -> some View {
        self.modifier(ValidationModifier(validation: flag))
    }
}

extension FormTextField {
    func validate(_ flag : @escaping ()-> Bool) -> some View {
        self.modifier(ValidationModifier(validation: flag))
    }
}

extension SecureField {
    func validate(_ flag : @escaping ()-> Bool) -> some View {
        self.modifier(ValidationModifier(validation: flag))
    }
}
