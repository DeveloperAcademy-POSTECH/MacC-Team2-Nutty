//
//  ArticleView.swift
//  Onbom
//
//  Created by Junyoo on 11/14/23.
//

import SwiftUI

struct ArticleView: View {
    @Binding var articleImage: Image
    
    var body: some View {
        NavigationStack {
            ScrollView {
                articleImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .ignoresSafeArea()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationBarBackButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "square.and.arrow.up")
                        .tint(.G5)
                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            
            appearance.backgroundColor = UIColor(Color.white.opacity(0.1))
            appearance.backgroundEffect = UIBlurEffect(style: .regular)
            appearance.shadowColor = nil
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    ArticleView(articleImage: .constant(Image("Article1")))
}
