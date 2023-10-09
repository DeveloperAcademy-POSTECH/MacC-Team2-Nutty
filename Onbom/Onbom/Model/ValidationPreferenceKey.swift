//
//  ValidationPreferenceKey.swift
//  Onbom
//
//  Created by moon on 10/10/23.
//

import SwiftUI

struct ValidationPreferenceKey : PreferenceKey {
    static var defaultValue: [Bool] = []
    
    static func reduce(value: inout [Bool], nextValue: () -> [Bool]) {
        value += nextValue()
    }
}

