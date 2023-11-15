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
    var webViewUrl: String
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                isShowPrivacyPolicyDetail = false
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(Color.G5)
            }
            .padding(.horizontal)
            MyWebView(urlToLoad: webViewUrl)
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
    PrivacyPolicyDetailView(isShowPrivacyPolicyDetail: .constant(true), webViewUrl: "https://lateral-donkey-cf6.notion.site/bf4f7e8dc1a2462badb6ca9e882dc370?pvs=4")
}
