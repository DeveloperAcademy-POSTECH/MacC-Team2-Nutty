//
//  ConfirmIDCardView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/01.
//

import SwiftUI

struct ConfirmIDCardView: View {
    @Binding var image: UIImage?
    @State private var frontIDNumber = ""
    @State private var backIDNumber = ""
    @State private var isValid = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("신분증 정보를 확인해 주세요")
                        .H2()
                        .foregroundColor(.B)
                    Spacer()
                }
                .padding()

                IDNumberInputField(frontNumber: $frontIDNumber, backNumber: $backIDNumber)
                
                Spacer()

                Rectangle()
                    .foregroundColor(.gray)
                    .overlay {
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        } else {
                            Text("사진없음")
                        }
                    }
                    .padding()

                //CTA Button
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("재촬영")
                    }
                    Spacer()
                    NavigationLink(destination: EmptyView()) {
                        Text("다음")
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButton()
    }
}

struct ConfirmIDCardView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmIDCardView(image: Binding.constant(UIImage()))
    }
}

