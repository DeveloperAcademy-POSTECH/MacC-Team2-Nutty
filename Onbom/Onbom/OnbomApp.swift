//
//  OnbomApp.swift
//  Onbom
//
//  Created by moon on 2023/09/22.
//

import SwiftUI
import FirebaseCore

@main
struct OnbomApp: App {
    
    @State private var isOnboarding: Bool = true
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(Patient())
                .environmentObject(Agent())
        }
    }
}
