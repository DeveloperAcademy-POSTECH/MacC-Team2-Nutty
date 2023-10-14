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
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(ApplicationInfo())
        }
    }
}

//    .onAppear {
//        for family: String in UIFont.familyNames {
//            print (family)
//            for names : String in
//                    UIFont.fontNames (forFamilyName: family){
//                print("=== \(names)")
//            }
//        }
//    }
