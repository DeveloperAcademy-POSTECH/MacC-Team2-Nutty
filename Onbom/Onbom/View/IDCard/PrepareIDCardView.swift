//
//  PrepareIDCardView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/01.
//

import SwiftUI

struct PrepareIDCardView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("신분증을 준비해주세요")
                
                NavigationLink(destination: TakeIDCardView()) {
                    Text("다음")
                }
            }
        }
    }
}

struct PrepareIDCardView_Previews: PreviewProvider {
    static var previews: some View {
        PrepareIDCardView()
    }
}
