//
//  AdBanner.swift
//  Onbom
//
//  Created by moon on 11/16/23.
//

import SwiftUI

struct AdBanner: View {
    private let timer = Timer.publish(every: 8, on: .main, in: .common).autoconnect()
    @State private var selectedPage = 0
    let width = UIScreen.main.bounds.width
    
    var body: some View {
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
        .frame(width: width, height: 84) // TODO: Invalid frame dimension
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
        .onReceive(timer, perform: { _ in
            selectedPage = (selectedPage + 1) % 2
        })
    
    }
}

#Preview {
    AdBanner()
}
