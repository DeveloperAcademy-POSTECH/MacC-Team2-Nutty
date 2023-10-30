//
//  PostCodeView.swift
//  Onbom
//
//  Created by 금가경 on 2023/10/04.
//

import SwiftUI
import WebKit

struct PostCodeViewer: UIViewRepresentable {
    let urlString = "https://developeracademy-postech.github.io/MacC-Team2-Nutty/"
    @Binding var isPostCodeViewPresented: Bool
    @Binding var selectedAddress: String
    
    func makeUIView(context: Context) -> WKWebView {
        // WKUserContentController에 Coordinator를 추가합니다.
        let userContentController = WKUserContentController()
        userContentController.add(context.coordinator, name: "callBackHandler")

        // WKWebView의 configuration에 userContentController를 설정합니다.
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        let label = UIActivityIndicatorView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.startAnimating()
        label.tag = 100
        
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: webView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: webView.centerYAnchor).isActive = true

        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        var parent: PostCodeViewer
        
        init(_ parent: PostCodeViewer) {
            self.parent = parent
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if let data = message.body as? [String: Any], let selectedAddress = data["roadAddress"] as? String {
                parent.selectedAddress = selectedAddress
                parent.isPostCodeViewPresented = false
            }
        }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if let viewWithTag = webView.viewWithTag(100) {
                viewWithTag.removeFromSuperview()
            }else{
                print("viewWithTag not found")
            }
        }
    }
}

struct PostCodeView_Previews: PreviewProvider {
    static var previews: some View {
        PostCodeViewer(isPostCodeViewPresented: .constant(false), selectedAddress: .constant(""))
    }
}
