//
//  ArticleListView.swift
//  Onbom
//
//  Created by Junyoo on 11/15/23.
//

import SwiftUI

struct ArticleListView: View {
    let articleList: [ArticleItem] = [.item1, .item2, .item3, .item4, .item5, .item6, .item7]
    @State private var selectedHashtag = "전체"
    @EnvironmentObject var navigation: NavigationManager
    
    var body: some View {
        ZStack {
            VStack {
                Color.W.frame(height: 270)
                Color.G2.ignoresSafeArea(.all)
            }

            VStack(spacing: 0) {
                Spacer().frame(height: 1)
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        Image("ArticleListTitle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(.bottom, 32)
                            .onTapGesture {
                                navigation.navigate(.Article4View)
                            }
                        
                        Text("이번 주 가장 인기있는 소식")
                            .H2()
                            .foregroundStyle(Color.B)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 12)
                        
                        ForEach(articleList, id: \.self) { item in
                            let details = item.detail
                            if details.number <= 3 {
                                Button {
                                    navigation.navigate(details.link)
                                } label: {
                                    PopulareListCell(image: details.image,
                                                     number: "\(details.number)",
                                                     content: details.content,
                                                     hastag: details.hashtag)
                                }
                            }
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("어르신께 딱 맞는 돌봄소식")
                                    .B1()
                                    .foregroundStyle(Color.G6)
                                Text("알려드릴까요?")
                                    .Cap4()
                                    .foregroundStyle(Color.G5)
                                    .padding(.top, 10)
                            }
                            Spacer()
                            Text("알림받기")
                                .B2()
                                .foregroundStyle(Color.Green4)
                                .padding(12)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(Color.Green2)
                                }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 40)
                        
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 12)
                            .foregroundStyle(Color.G2)
                            .padding(.vertical, 32)
                        
                        Text("복지정보 한눈에 보기")
                            .H2()
                            .foregroundStyle(Color.B)
                            .padding(.horizontal, 20)
                        
                        HashtagCarousel(selectedHashtag: $selectedHashtag)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(articleList, id:\.self) { item in
                                let details = item.detail
                                let contentNoNewline = details.content.replacingOccurrences(of: "\n", with: " ")
                                if selectedHashtag == "전체" || details.hashtag.contains(selectedHashtag) {
                                    Button {
                                        navigation.navigate(details.link)
                                    } label: {
                                        ArticleListCell(image: details.image, content: contentNoNewline)
                                            .accentColor(Color.B)
                                    }
                                }
                            }
                        }
                    }
                    .background(Color.W)
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text(" • ")
                                .Cap5()
                                .foregroundStyle(Color.G4)
                            Text("온봄 ‘복지정보 한눈에 보기’의 모든 정보는 참고 용도로만 활용 가능하며, 의학적 진단, 진료, 혹은 치료를 대신하지 않습니다.")
                                .Cap5()
                                .foregroundStyle(Color.G4)
                        }
                        .padding(.bottom, 10)
                        
                        HStack(alignment: .top) {
                            Text(" • ")
                                .Cap5()
                                .foregroundStyle(Color.G4)
                            Text("의료 지원 및 의학에 근거한 전문적인 판단이 필요한 경우 의료기관에 방문해 전문가와 상담하십시오.")
                                .Cap5()
                                .foregroundStyle(Color.G4)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 22)
                    .padding(.bottom, 160)
                }
            }
        }
        .background(Color.W)
        .onAppear {
            let appearance = UINavigationBarAppearance()
            
            appearance.backgroundColor = UIColor(Color.white.opacity(0.1))
            appearance.backgroundEffect = UIBlurEffect(style: .regular)
            appearance.shadowColor = nil
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        .navigationDestination(for: HomeRoute.self) { route in
            switch(route) {
            case .Article1View: ArticleDetailView(articleName: "Article1")
            case .Article2View: ArticleDetailView(articleName: "Article2")
            case .Article3View: ArticleDetailView(articleName: "Article3")
            case .Article4View: ArticleDetailView(articleName: "Article4")
            case .Article5View: ArticleDetailView(articleName: "Article5")
            case .Article6View: ArticleDetailView(articleName: "Article6")
            case .Article7View: ArticleDetailView(articleName: "Article7")
            default:            RejectView()
            }
        }
    }
    
    enum ArticleItem {
        case item1, item2, item3, item4, item5, item6, item7
        
        var detail: (image: String, content: String, number: Int, hashtag: String, link: HomeRoute) {
            switch self {
            case .item1:
                return ("house-human", "치매가족휴가제로\n한 숨 돌려보세요", 1, "가족지원", .Article1View)
            case .item2:
                return ("house-cross", "부담을 덜어드리는\n노인돌봄 종합서비스", 2, "치료비", .Article2View)
            case .item3:
                return ("human", "집에서 가까운\n치매안심센터 찾기", 3, "예방관리", .Article3View)
            case .item4:
                return ("stethoscope", "필요했던 복지용구\n한번에 신청해 보세요", 4, "조호물품", .Article4View)
            case .item5:
                return ("idtag", "인식표 나눔사업\n여기서 바로 알아보기", 5, "실종예방", .Article5View)
            case .item6:
                return ("hospital", "장기요양등급,\n1분만에 시설등급 신청", 6, "장기요양보험", .Article6View)
            case .item7:
                return ("syringe", "어르신을 위한\n무료 독감 접종 예약하기", 7, "조기검진", .Article7View)
            }
        }
    }
}

fileprivate struct HashtagCarousel: View {
    @Binding var selectedHashtag: String
    let hashtags = ["전체", "장기요양보험", "조기검진","예방관리", "가족지원", "치료비", "조호물품", "실종예방"]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(hashtags, id:\.self) { tag in
                    Text(tag)
                        .Cap4()
                        .foregroundStyle(selectedHashtag == tag ? Color.W : Color.G5)
                        .padding(8)
                        .padding(.horizontal, 5)
                        .background {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(selectedHashtag == tag ? Color.G6 : Color.W)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .strokeBorder(selectedHashtag == tag ? Color.clear : Color.G3, lineWidth: 1)
                                )
                        }
                        .padding(.leading, tag == "전체" ? 20 : 0 )
                        .padding(.trailing, tag == "실종예방" ? 20 : 0 )
                        .onTapGesture {
                            selectedHashtag = tag
                        }
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.vertical, 12)
    }
}

fileprivate struct PopulareListCell: View {
    var image = ""
    var number = ""
    var content = ""
    var hastag = ""
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 64)
            Text(number)
                .B2()
                .foregroundStyle(Color.Green4)
                .padding(.leading, 16)
                .padding(.top, 3)
            VStack(alignment: .leading, spacing: 0) {
                Text(content)
                    .B3()
                    .foregroundStyle(Color.B)
                    .multilineTextAlignment(.leading)
                Text("# \(hastag)")
                    .Cap4()
                    .foregroundStyle(Color.G4)
                    .padding(.top, 6)
            }
            .padding(.leading, 13)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
}

fileprivate struct ArticleListCell: View {
    var image = ""
    var content = ""
    
    var body: some View {
        HStack(spacing: 0) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 64)
            Text(content)
                .B3()
                .padding(.leading, 16)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
}

#Preview {
    ArticleListView()
}
