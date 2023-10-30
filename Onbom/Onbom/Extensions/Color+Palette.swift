//
//  Color+Palette.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/09/27.
//

import SwiftUI

extension Color {
    // MARK: Hex Init
    init(hex: String, opacity: Double = 1.0) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xff) / 255
        let green = Double((rgb >> 8) & 0xff) / 255
        let blue = Double((rgb >> 0) & 0xff) / 255
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

extension Color {
    
    // MARK: Grayscale
    static var W : Self {
        .init(hex: "#FFFFFF")
    }
    static var G1: Self {
        .init(hex: "#F9F9F9")
    }
    
    static var G2: Self {
        .init(hex: "#F6F6F5")
    }
    
    static var G3: Self {
        .init(hex: "#D6D6D6")
    }
    
    static var G4: Self {
        .init(hex: "#A3A3A3")
    }
    
    static var G5: Self {
        .init(hex: "#646464")
    }
    
    static var G6: Self {
        .init(hex: "#2F2F2F")
    }
    
    static var G7: Self {
        .init(hex: "#667571")
    }
    
    static var B: Self {
        .init(hex: "#191919")
    }
    
    // MARK: Color
    static var R: Self {
        .init(hex: "#FF4E4E")
    }
    
    static var L: Self {
        .init(hex: "#E5FF9A")
    }
    
    static var Green1: Self {
        .init(hex: "#ECF5EE")
    }
    
    static var Green2: Self {
        .init(hex: "#DAF0DF")
    }
    
    static var Green3: Self {
        .init(hex: "#AED9CF")
    }
    
    static var Green4: Self {
        .init(hex: "#00A07A")
    }
    
    static var Green5: Self {
        .init(hex: "#00775A")
    }
    
    // MARK: Opacity
    static var TG1: Self {
        .init(hex: "#000000", opacity: 0.4)
    }
    
    static var TG2: Self {
        .init(hex: "#D6D6D6", opacity: 0.4)
    }
    
    static var TGreen: Self {
        .init(hex: "#00A07A", opacity: 0.7)
    }
    
    // MARK: Gradation
    static var TPW: Self {
        .init(hex: "FFFFFF", opacity: 0)
    }
}

// MARK: Preview
struct Color_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            VStack {
                Color.W
                Color.G1
                Color.G2
                Color.G3
                Color.G4
                Color.G5
                Color.G6
                Color.B
            }
            VStack {
                Color.R
                Color.L
                Color.Green1
                Color.Green2
                Color.Green3
                Color.Green4
                Color.Green5
            }
            VStack {
                LinearGradient(
                    colors: [
                    .TPW,
                    .W
                ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            VStack {
                Color.TG1
                Color.TG2
                Color.TGreen
            }
        }
        .padding()
    }
}

