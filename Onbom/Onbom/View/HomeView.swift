//
//  HomeView.swift
//  Onbom
//
//  Created by moon on 10/14/23.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedPage = 0
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    @EnvironmentObject var pdfManager: PDFManager
    let width = UIScreen.main.bounds.width
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            // 쇼케이스용 pdfViewer
            TabView(selection: $selectedPage){
                Image("Banner1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .tag(0)
                Image("Banner2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(width: width, height: 84)
            .overlay(
                Text("\(selectedPage + 1) / 2")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 10, weight: .regular))
                    .padding(.vertical, 3.5)
                    .padding(.horizontal, 5)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.TG1))
                    .offset(x: -18, y: -12),
                alignment: .bottomTrailing
            )
            VStack(spacing: 0) {
                Spacer()
                Text("집에서 간편하게\n장기요양등급 신청해 보세요")
                    .T1()
                    .foregroundColor(Color.B)
                    .lineSpacing(4)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 28)
                    .frame(maxWidth: .infinity)
                Image("MainView")
                    .padding(.bottom, 15)
                CTAButton.CustomButtonView(
                    style: .main)
                {
                    homeNavigation.navigate(.DescriptionView)
                } label: {
                       Text("지금 바로 신청하기")
                }
                .padding(20)
            }
            .frame(width: width - 40, height: width - 40)
            .background(RoundedRectangle(cornerRadius: 20).fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 5))
            .padding(20)
            .padding(.top, -8)
             
            HStack(spacing: 0) {
                Text("본인 부담금 계산기")
                    .B2()
                    .foregroundColor(Color.B)
                    .padding(.leading, 19)
                    .padding(.vertical, 20)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.G4)
                    .padding(.trailing, 19)
            }
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 5))
            .padding(.horizontal, 20)
            .padding(.bottom, 25)
            
            Text("복지정보 한눈에 보기")
                .H3()
                .foregroundColor(Color.B)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.bottom, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    let images = [Image("MainView_Green"),
                                  Image("MainView_Blue"),
                                  Image("MainView_Purple"),
                                  Image("MainView_Yellow"),
                                  Image("MainView_Pink"),
                                  Image("MainView_Brown"),]
                    let colors = [Color.init(hex: "E2F6E2"),
                                  Color.init(hex: "D6EDF8"),
                                  Color.init(hex: "DDDEF9"),
                                  Color.init(hex: "FFFBD4"),
                                  Color.init(hex: "FFE7F7"),
                                  Color.init(hex: "DFD6CE"),]
                    let circleColors = [Color.init(hex: "B4E8B4"),
                                        Color.init(hex: "9FD4ED"),
                                        Color.init(hex: "BFC1F6"),
                                        Color.init(hex: "FAF1A4"),
                                        Color.init(hex: "FECBED"),
                                        Color.init(hex: "D6C4B5"),]
                    let contents = ["치매가족휴가제로\n한 숨 돌려보세요",
                                    "부담을 덜어드리는\n노인돌봄종합서비스",
                                    "가장 가까운\n치매상담센터 찾기",
                                    "필요했던 복지용구\n한번에 신청해보세요",
                                    "인식표 나눔사업\n여기서 바로 알아보기",
                                    "장기요양등급,\n1분만에 시설등급 받기",]
                    
                    ForEach(0..<6) { i in
                        VStack(alignment: .leading, spacing: 0) {
                            ZStack {
                                Circle()
                                    .fill(circleColors[i])
                                    .frame(maxWidth: 64, maxHeight: 64)
                                images[i]
                            }
                            .padding(.bottom, 31)
                            Text(contents[i])
                                .foregroundColor(Color.B)
                                .T4()
                            Text("알림 설정하기")
                                .foregroundColor(Color.G5)
                                .Cap4()
                                .padding(.top, 5)
                        }
                        .padding(20)
                        .frame(width: 160, height: 194, alignment: .topLeading)
                        .background(colors[i])
                        .cornerRadius(12)
                        .padding(.leading, i == 0 ? 20 : 0)
                        .padding(.trailing, i == 5 ? 20 : 10)
                    }
                }
            }
            Spacer().frame(height: 100)
        }
        .background(Color.G2)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Text("온봄")
                    .foregroundColor(Color.PB4)
                    .font(.custom("Dongle-Bold", size: 35))
                    .padding(.leading, 7)
            }
            ToolbarItem(placement: .confirmationAction) {
                Image("notification")
                    .padding(.trailing, 7)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeNavigationViewModel())
            .environmentObject(PDFManager())
    }
}
