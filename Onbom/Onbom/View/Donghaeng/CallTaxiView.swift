//
//  CallTaxiView.swift
//  Onbom
//
//  Created by Sebin Kwon on 10/30/23.
//

import SwiftUI

struct CallTaxiView: View {
    @State private var isShowModal = false
    
    var body: some View {
        VStack {
            Text("포항시 동행콜 배차신청하기")
                .H1()
                .foregroundStyle(Color.G6)
                .padding(.bottom, 10)
            Text("전화로 간단히 포항시 동행콜을 신청해요")
                .Cap2()
                .foregroundStyle(Color.G4)
                .padding(.bottom)
            Spacer()
            Image("CallTaxi")
                .resizable()
                .scaledToFit()
            Spacer()
            Text("•  통화 전 시간과 장소를 미리 생각해주세요")
                .Cap3()
                .foregroundStyle(Color.G5)
                .padding(.bottom, 50)
            CTAButton.CustomButtonView(
                style: .primary(isDisabled: false))
            {
                if checkIsOpeningHours() {
                    if let url = URL(string: "tel://18009300") {
                        UIApplication.shared.open(url)
                    }
                } else {
                    isShowModal = true
                }
            } label: {
                Text("콜센터에 전화로 신청하기")
            }
        }
        .sheet(isPresented: $isShowModal) {
            CallTaxiModalView(isShowModal: $isShowModal)
                .presentationDetents([.fraction(0.5)])
        }
        .padding(.top, 75)
        .padding(.horizontal, 20)
        .navigationBarBackButton()
    }
    
    
    func checkIsOpeningHours() -> Bool {
        var isOpen = false
        let today = Date()
        let calendar = Calendar.current.dateComponents([.weekday, .hour], from: today)
        if let weekday = calendar.weekday, let hours = calendar.hour {
            switch weekday {
            case 2...6 where 7..<23 ~= hours,
                7 where 7..<18 ~= hours,
                1 where 7..<16 ~= hours:
                isOpen = true
            default:
                isOpen = false
            }
        }
        return isOpen
    }

}

struct CallTaxiModalView: View {
    @Binding var isShowModal: Bool
    var body: some View {
        VStack {
            Image("warning")
                .padding(.top, 34)
                .padding(.bottom, 18)
            Text("지금은 콜센터 운영 시간이 아니에요")
                .T1()
                .foregroundStyle(Color.B)
                .padding(.bottom, 20)
            VStack(alignment: .leading, spacing: 3) {
                Text("•  평 일 : 오전 7시 부터 오후 10시")
                    .Cap3()
                Text("•  토요일 : 오전 7시 부터 오후 6시")
                    .Cap3()
                Text("•  일 · 공휴일 : 오전 7시 부터 오후 4시")
                    .Cap3()
            }
            .foregroundStyle(Color.G5)
            .padding(.bottom)
            Text("콜센터 운영 시간이 되면 알림을 보내드릴까요?")
                .Cap3()
                .foregroundStyle(Color.G5)
            Spacer()
            HStack {
                CTAButton.CustomButtonView(style: .secondary) {

                } label: {
                    Text("네, 알려주세요")
                }
                CTAButton.CustomButtonView(style: .secondary) {
                    isShowModal = false
                } label: {
                    Text("필요 없어요")
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    CallTaxiView()
}
