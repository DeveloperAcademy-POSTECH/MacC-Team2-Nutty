//
//  PrivacyPolicyDetailView.swift
//  Onbom
//
//  Created by Sebin Kwon on 11/14/23.
//

import SwiftUI
import WebKit

struct PrivacyPolicyDetailView: View {
    @Binding var isShowPrivacyPolicyDetail: Bool
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                isShowPrivacyPolicyDetail = false
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(Color.G5)
            }
            .padding(.horizontal)
            MyWebView(urlToLoad: "https://lateral-donkey-cf6.notion.site/7e4a8717592040078e844a8f87744a25?pvs=4")
        }
    }
}

struct MyWebView: UIViewRepresentable {
    var urlToLoad: String

    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<MyWebView>) {
    }
}

#Preview {
    PrivacyPolicyDetailView(isShowPrivacyPolicyDetail: .constant(true))
}
