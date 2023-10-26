//
//  CustomNavigationBar.swift
//  Onbom
//
//  Created by moon on 10/27/23.
//

import SwiftUI

struct CustomNavigationBar<V, R>: View where V: View, R: View {
    
    let cancellation: V?
    let confirmation: R?
    
    init(@ViewBuilder cancellation: @escaping () -> V?, @ViewBuilder confirmation: @escaping () -> R?) {
        self.cancellation = cancellation()
        self.confirmation = confirmation()
    }
    
    var body: some View {
        HStack(alignment: .center) {
            self.cancellation
            Spacer()
            self.confirmation
        }
        .ignoresSafeArea()
    }
}

