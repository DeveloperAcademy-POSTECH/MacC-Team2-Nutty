//
//  TextStyle+Extension.swift
//  Onbom
//
//  Created by moon on 10/6/23.
//

import SwiftUI

extension Text {
    func H1() -> some View {
        self.font(.system(size:22, weight: .bold))
    }
    func H2() -> some View {
        self.font(.system(size:18, weight: .heavy))
    }
    
    func T1() -> some View {
        self.font(.system(size:19, weight: .bold))
    }
    func T2() -> some View {
        self.font(.system(size:18, weight: .bold))
    }
    func T3() -> some View {
        self.font(.system(size:17, weight: .bold))
    }
    func T4() -> some View {
        self.font(.system(size:14, weight: .bold))
    }
    func T5() -> some View {
        self.font(.system(size:14, weight: .semibold))
    }
    
    func B1() -> some View {
        self.font(.system(size:16, weight: .bold))
    }
    func B2() -> some View {
        self.font(.system(size:16, weight: .bold))
    }
    func B3() -> some View {
        self.font(.system(size:13, weight: .medium))
    }
    
    func Label() -> some View {
        self.font(.system(size:14, weight: .semibold))
    }
    
    func Cap1() -> some View {
        self.font(.system(size:16, weight: .medium))
    }
    func Cap2() -> some View {
        self.font(.system(size:15, weight: .medium))
    }
    func Cap3() -> some View {
        self.font(.system(size:14, weight: .medium))
    }
    func Cap4() -> some View {
        self.font(.system(size:13, weight: .medium))
    }
    func Cap5() -> some View {
        self.font(.system(size:11, weight: .regular))
    }
}
