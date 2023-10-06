//
//  MainView.swift
//  Onbom
//
//  Created by moon on 2023/10/06.
//

import SwiftUI

struct MainView: View {
    @State private var selectedPage = 0
    
    var body: some View {
        NavigationView{
            ScrollView {
                TabView(selection: $selectedPage){
                    Rectangle().fill(Color.G4)
                        .tag(0)
                    Rectangle().fill(Color.G3)
                        .tag(1)
                    Rectangle().fill(Color.G4)
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(width: UIScreen.main.bounds.width, height: 84)
                .overlay(
                    Text("\(selectedPage + 1) / 3")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 10, weight: .regular))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 5)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.TG1))
                        .offset(x: -18, y: -12),
                    alignment: .bottomTrailing
                )
                
                VStack(alignment: .center){
                    Text("집에서 간편하게\n장기요양등급 신청해 보세요")
                        .T1() // weight가 figma랑 다른거 같은데
                        .lineSpacing(4)
                        .multilineTextAlignment(.center)
                        .padding(.top, 30)
                        .padding(.bottom, 28)
                        .frame(maxWidth: .infinity)
                    Rectangle()
                        .fill(Color.G2)
                        .frame(width: 150, height: 120)
                        .padding(.bottom, 30)
                    
                    Button{
                    } label: {
                        Text("지금 바로 신청하기")
                            .foregroundColor(Color.white)
                            .B1()
                            .padding(.vertical, 20) // 왜 text height만큼 padding이 생기지?
                            .frame(maxWidth: .infinity)
                    }
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.PB4))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                .background(RoundedRectangle(cornerRadius: 20).fill(.white))
                .padding(20)
                
                HStack {
                    Text("본인 부담금 계산기")
                        .B2()
                        .padding(.leading, 19)
                        .padding(.vertical, 20)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .padding(.trailing, 19)
                }
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
                .padding(.horizontal, 20)
                .padding(.bottom, 36)
                
                Text("복지정보 한눈에 보기")
                    .H2()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.bottom, 14)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(0..<10) { i in
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(hue: Double(i) / 10, saturation: 1, brightness: 1).gradient)
                                .frame(width: 300, height: 100)
                                .padding(.leading, 20)
                        }
                    }
                }
                
                
            }
            .background(Color.G2)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Text("ONBOM")
                        .foregroundColor(Color.PB4) // 피그마랑 색깔이 살짝 다른거같은데...?
                        .font(.system(size:24, weight: .bold))
                }
                ToolbarItem(placement: .confirmationAction) {
                    Image("notification")
                }
            }
        }
    }
}

#Preview {
    MainView()
}
