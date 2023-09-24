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
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
