//
//  CustomNavigationBar.swift
//  Onbom
//
//  Created by moon on 10/27/23.
//

import SwiftUI

struct CustomNavigationBar<V, R>: View where V: View, R: View {
    
    let leading: V?
    let trailing: R?
    
    init(@ViewBuilder leading: @escaping () -> V?, @ViewBuilder trailing: @escaping () -> R?) {
        self.leading = leading()
        self.trailing = trailing()
    }
    
    var body: some View {
        HStack(alignment: .center) {
            self.leading
            Spacer()
            self.trailing
        }
    }
}

