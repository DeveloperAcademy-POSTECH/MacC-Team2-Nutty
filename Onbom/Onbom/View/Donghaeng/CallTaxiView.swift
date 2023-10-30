//
//  CallTaxiView.swift
//  Onbom
//
//  Created by Sebin Kwon on 10/30/23.
//

import SwiftUI

struct CallTaxiView: View {
    var body: some View {
        VStack {
            Text("포항시 동행콜 배차신청하기")
            Text("어쩌구 전화로 신청할까요?")
            Image("SubmitLoadingView")
//            Image("warning")
        }
    }
}

#Preview {
    CallTaxiView()
}
