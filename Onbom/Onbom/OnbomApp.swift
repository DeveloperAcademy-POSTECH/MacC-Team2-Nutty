//
//  OnbomApp.swift
//  Onbom
//
//  Created by moon on 2023/09/22.
//

import SwiftUI
import FirebaseCore
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct OnbomApp: App {
    
    func configureOptions() -> FirebaseOptions {
        let options = FirebaseOptions(googleAppID: "1:349207644054:ios:71f455f29832d34f7a3fb7",
                                               gcmSenderID: "349207644054")
        options.apiKey = "AIzaSyARaTo24SMU2pKkzLLFoNld9oTLTIVT7js"
        options.projectID = "swift-firebase-example-12b92"

        options.bundleID = "Nutty.Onbom"
        options.databaseURL = "https://myproject.firebaseio.com"
        options.deepLinkURLScheme = "myapp://"
        options.storageBucket = "swift-firebase-example-12b92.appspot.com"
        
        return options
    }
    
    init() {
        
        let options = configureOptions()
        FirebaseApp.configure(options: options)
        
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"]!
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
				.environmentObject(AuthenticationViewModel())
				.onOpenURL { url in
                if (AuthApi.isKakaoTalkLoginUrl(url) == false) {
                    print("유효하지 않은 url입니다")
                    return
                }
                let _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
}
