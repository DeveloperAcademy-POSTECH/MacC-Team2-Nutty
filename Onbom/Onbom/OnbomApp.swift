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
    
    @State private var isOnboarding: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if(isOnboarding) {
                OnboardingView(isOnboarding: $isOnboarding)
            } else {
                MainView()
                    .environmentObject(Patient())
                    .environmentObject(Agent())
            }
        }
    }
}
