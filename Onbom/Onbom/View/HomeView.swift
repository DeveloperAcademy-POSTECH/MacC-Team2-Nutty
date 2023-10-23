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
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            // 쇼케이스용 pdfViewer
            TabView(selection: $selectedPage){
                NavigationLink {
                    PDFViewer(pdfData: pdfManager.PDFDatas.first )
                } label: {
                    Rectangle().fill(Color.G4)
                }
                .tag(0)
                NavigationLink {
                    PDFViewer(pdfData: pdfManager.PDFDatas.first )
                } label: {
                    Rectangle().fill(Color.G3)
                        
                }
                .tag(1)
                NavigationLink {
                    PDFViewer(pdfData: pdfManager.PDFDatas.first )
                } label: {
                    Rectangle().fill(Color.G4)
                        
                }
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
            VStack(alignment: .center, spacing: 0) {
                Text("집에서 간편하게\n장기요양등급 신청해 보세요")
                    .T1()
                    .foregroundColor(Color.B)
                    .lineSpacing(4)
                    .multilineTextAlignment(.center)
                    .padding(.top, 30)
                    .padding(.bottom, 28)
                    .frame(maxWidth: .infinity)
                Rectangle()
                    .fill(Color.G2)
                    .frame(width: 150, height: 120)
                    .padding(.bottom, 33)
                Button {
                    homeNavigation.navigate(.ApplyTypeView)
                } label: {
                    Text("지금 바로 신청하기")
                        .foregroundColor(Color.white)
                        .B1()
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                }
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.PB4))
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
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
            .padding(.bottom, 36)
            
            
            Text("복지정보 한눈에 보기")
                .H2()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.bottom, 14)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    let colors = [Color.init(hex: "E2F6E2"),
                                  Color.init(hex: "D6EDF8"),
                                  Color.init(hex: "DDDEF9"),
                                  Color.init(hex: "FFFBD4"),
                                  Color.init(hex: "FFE7F7"),
                                  Color.init(hex: "DFD6CE"),]
                    let contents = ["치매가족휴가제로\n한 숨 돌려보세요",
                                    "부담을 덜어드리는\n노인돌봄종합서비스",
                                    "가장 가까운\n치매상담센터 찾기",
                                    "필요했던 복지용구\n한번에 신청해보세요",
                                    "인식표 나눔사업\n여기서 바로 알아보기",
                                    "장기요양등급,\n1분만에 시설등급 받기",]
                    
                    ForEach(0..<6) { i in
                        VStack(alignment: .leading, spacing: 0) {
                            Circle()
                                .fill(Color.white)
                                .frame(maxWidth: 64, maxHeight: 64)
                                .padding(.bottom, 31)
                            Text(contents[i])
                                .foregroundColor(Color.B)
                                .T4()
                            Text("알림 설정하기")
                                .foregroundColor(Color.G5)
                                .Cap3()
                        }
                        .padding(20)
                        .frame(width: 160, height: 194, alignment: .topLeading)
                        .background(colors[i])
                        .cornerRadius(12)
                        .padding(.leading, 20)
                        
                    }
                    Spacer().frame(width: 20)
                }
            }
            Spacer().frame(height: 50)
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
