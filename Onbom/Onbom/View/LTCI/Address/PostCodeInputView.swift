//
//  PostCodeInputView.swift
//  Onbom
//
//  Created by 금가경 on 2023/10/04.
//

import SwiftUI

struct PostCodeInputView: View {
    
    @Binding var isPostCodeViewPresented: Bool
    @Binding var cityAddress: String

    var body: some View {
        PostCodeViewer(isPostCodeViewPresented: $isPostCodeViewPresented,
                     selectedAddress: $cityAddress)
        .navigationBarBackButton()
    }
}

//struct PostCodeInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCodeInputView()
//    }
//}
