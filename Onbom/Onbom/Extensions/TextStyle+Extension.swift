//
//  TextStyle+Extension.swift
//  Onbom
//
//  Created by moon on 10/6/23.
//

import SwiftUI

extension Text {
    func H1() -> some View {
        self.font(.custom("Pretendard-Bold", size: 28)).lineSpacing(0.4 * 14)
    }
    func H2() -> some View {
        self.font(.custom("Pretendard-Bold", size: 22)).lineSpacing(0.3 * 11)
    }
    func H3() -> some View {
        self.font(.custom("Pretendard-ExtraBold", size: 18))
    }

    func T1() -> some View {
        self.font(.custom("Pretendard-Bold", size: 19)).lineSpacing(0.3 * 9.5)
    }
    func T2() -> some View {
        self.font(.custom("Pretendard-Bold", size: 18)).lineSpacing(0.3 * 9)
    }
    func T3() -> some View {
        self.font(.custom("Pretendard-Bold", size: 17))
    }
    func T4() -> some View {
        self.font(.custom("Pretendard-Bold", size: 14)).lineSpacing(0.3 * 7)
    }
    func T5() -> some View {
        self.font(.custom("Pretendard-SemiBold", size: 14)).lineSpacing(0.6 * 7)
    }
    
    func B1() -> some View {
        self.font(.custom("Pretendard-Bold", size: 16))
    }
    func B2() -> some View {
        self.font(.custom("Pretendard-SemiBold", size: 16))
    }
    func B3() -> some View {
        self.font(.custom("Pretendard-Medium", size: 16)).lineSpacing(0.4 * 8)
    }
    func B4() -> some View {
        self.font(.custom("Pretendard-Medium", size: 16))
    }
    func B4() -> some View {
        self.font(.system(size:12, weight: .medium))
    }
    
    func Label() -> some View {
        self.font(.custom("Pretendard-Semibold", size: 16))
    }
    func Cap1() -> some View {
        self.font(.custom("Pretendard-Medium", size: 16)).lineSpacing(0.3 * 8)
    }
    func Cap2() -> some View {
        self.font(.custom("Pretendard-Medium", size: 15)).lineSpacing(0.4 * 7.5)
    }
    func Cap3() -> some View {
        self.font(.custom("Pretendard-Medium", size: 14))
    }
    func Cap4() -> some View {
        self.font(.custom("Pretendard-Medium", size: 13))
    }
    func Cap5() -> some View {
        self.font(.custom("Pretendard-Bold", size: 11))
    }
    func Cap6() -> some View {
        self.font(.custom("Pretendard-Regular", size: 11))
    }
}

extension Text {
    func Title() -> some View {
        self.H2().foregroundColor(.B)
    }
}
