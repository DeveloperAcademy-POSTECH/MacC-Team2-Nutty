//
//  ArticleDetailView.swift
//  Onbom
//
//  Created by Junyoo on 11/14/23.
//

import SwiftUI

struct ArticleDetailView: View {
    var articleName: String
    @EnvironmentObject var navigation: NavigationManager

    var body: some View {
        ScrollView {
            Image(articleName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .ignoresSafeArea()
        }
        .navigationBarBackButton()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ShareLink(
                    item: Image(articleName),
                    preview: SharePreview("square.and.arrow.up",
                                          image: Image(articleName))
                )
                .tint(.G5)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ArticleDetailView(articleName: "Article1")
}
