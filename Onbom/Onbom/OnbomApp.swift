//
//  OnbomApp.swift
//  Onbom
//
//  Created by moon on 2023/09/22.
//

import SwiftUI

@main
struct OnbomApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
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
