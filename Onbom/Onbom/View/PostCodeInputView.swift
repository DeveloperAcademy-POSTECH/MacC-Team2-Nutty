//
//  PostCodeInputView.swift
//  Onbom
//
//  Created by 금가경 on 2023/10/04.
//

import SwiftUI

struct PostCodeInputView: View {
    @State private var isPostCodeViewPresented = false
    @State private var selectedAddress = ""
    
    var body: some View {
        VStack {
            Button("Open PostCodeView") {
                isPostCodeViewPresented.toggle()
            }
            Text("주소 : \(selectedAddress)")
        }
        .sheet(isPresented: $isPostCodeViewPresented) {
            PostCodeView(isPostCodeViewPresented: $isPostCodeViewPresented, selectedAddress: $selectedAddress)
        }
    }
}

struct PostCodeInputView_Previews: PreviewProvider {
    static var previews: some View {
        PostCodeInputView()
    }
}
