//
//  TextStyle+Extension.swift
//  Onbom
//
//  Created by moon on 10/6/23.
//

import SwiftUI

extension Text {
    func H1() -> some View {
        customTextStyle(fontName: "Pretendard-Bold", fontSize: 28, lineSpacing: 140, kerning: -3)
    }

    func H2() -> some View {
        customTextStyle(fontName: "Pretendard-Bold", fontSize: 18, lineSpacing: 100, kerning: -2)
    }

    func T1() -> some View {
        customTextStyle(fontName: "Pretendard-Bold", fontSize: 22, lineSpacing: 130, kerning: -2)
    }
    func T2() -> some View {
        customTextStyle(fontName: "Pretendard-Bold", fontSize: 19, lineSpacing: 130, kerning: -3)
    }
    func T3() -> some View {
        customTextStyle(fontName: "Pretendard-Bold", fontSize: 14, lineSpacing: 130, kerning: -3)
    }
    func T4() -> some View {
        customTextStyle(fontName: "Pretendard-SemiBold", fontSize: 14, lineSpacing: 160, kerning: -2)
    }
    
    func B1() -> some View {
        customTextStyle(fontName: "Pretendard-Bold", fontSize: 16, lineSpacing: 100, kerning: -1)
    }
    func B2() -> some View {
        customTextStyle(fontName: "Pretendard-SemiBold", fontSize: 16, lineSpacing: 100, kerning: -1)    }
    func B3() -> some View {
        customTextStyle(fontName: "Pretendard-Medium", fontSize: 16, lineSpacing: 140, kerning: -3)
    }
    func B4() -> some View {
        customTextStyle(fontName: "Pretendard-Medium", fontSize: 16, lineSpacing: 100, kerning: -3)
    }
    
    func Label() -> some View {
        customTextStyle(fontName: "Pretendard-SemiBold", fontSize: 17, lineSpacing: 100, kerning: -2)
    }
    func Cap1() -> some View {
        customTextStyle(fontName: "Pretendard-Medium", fontSize: 16, lineSpacing: 160, kerning: -2)
    }
    func Cap2() -> some View {
        customTextStyle(fontName: "Pretendard-Medium", fontSize: 16, lineSpacing: 130, kerning: -2)
    }
    func Cap3() -> some View {
        customTextStyle(fontName: "Pretendard-Medium", fontSize: 15, lineSpacing: 140, kerning: -2)
    }
    func Cap4() -> some View {
        customTextStyle(fontName: "Pretendard-Medium", fontSize: 14, lineSpacing: 100, kerning: -2)
    }
    func Cap5() -> some View {
        customTextStyle(fontName: "Pretendard-Regular", fontSize: 13, lineSpacing: 160, kerning: -2)
    }
    func Cap6() -> some View {
        customTextStyle(fontName: "Pretendard-Bold", fontSize: 11, lineSpacing: 100, kerning: 0)
    }
    func Cap7() -> some View {
        customTextStyle(fontName: "Pretendard-Regular", fontSize: 11, lineSpacing: 100, kerning: 0)
    }
}

extension Text {
    func customTextStyle(fontName: String, fontSize : CGFloat, lineSpacing: CGFloat, kerning: CGFloat) -> some View {
        self
            .font(.custom(fontName, size: fontSize))
            .lineSpacing(fontSize / 2 * (lineSpacing - 100)/100)
            .ckerning(kerning/10)
    }
}

struct Text_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStack {
                Text("H1 Bold 28pt 140% -3%")
                    .H1()
                Text("H2 Bold 18pt 100% -2%")
                    .H2()
            }
            VStack {
                Text("T1 Bold 22pt 130% -2%")
                    .T1()
                Text("T2 Bold 19pt 130% -3%")
                    .T2()
                Text("T3 Bold 14pt 130% -3%")
                    .T3()
                Text("T4 SemiBold 14pt 160% -2%")
                    .T4()
            }
            VStack {
                Text("B1 Bold 16pt 100% -1%")
                    .B1()
                Text("B2 SemiBold 16pt 100% -1%")
                    .B2()
                Text("B3 Medium 16pt 140% -3%")
                    .B3()
                Text("B4 Medium 16pt 100% -3%")
                    .B4()
            }
            VStack {
                Text("Label SemiBold 17pt 100% -2%")
                    .Label()
            }
            VStack {
                Text("Cap1 Medium 16pt 160% -2%")
                    .Cap1()
                Text("Cap2 Medium 16pt 130% -2%")
                    .Cap2()
                Text("Cap3 Medium 15pt 140% -2%")
                    .Cap3()
                Text("Cap4 Medium 14pt 100% -2%")
                    .Cap4()
                Text("Cap5 Regular 13pt 160% -2%")
                    .Cap5()
                Text("Cap6 Bold 11pt 100% 0%")
                    .Cap6()
                Text("Cap7 Regular 11pt 100% 0%")
                    .Cap7()
            }
        }
    }
}
