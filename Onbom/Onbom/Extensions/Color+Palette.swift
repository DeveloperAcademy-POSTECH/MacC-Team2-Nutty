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
    
    static var PB1: Self {
        .init(hex: "#EDEEFF")
    }
    
    static var PB2: Self {
        .init(hex: "#C3C6FF")
    }
    
    static var PB3: Self {
        .init(hex: "#575DE1")
    }
    
    static var PB4: Self {
        .init(hex: "#343E9A")
    }
    
    // MARK: Opacity
    static var TG1: Self {
        .init(hex: "#F9F9F9", opacity: 0.4)
    }
    
    static var TG2: Self {
        .init(hex: "#D6D6D6", opacity: 0.4)
    }
    
    static var TPB: Self {
        .init(hex: "#575DE1", opacity: 0.7)
    }
}

// MARK: Preview
struct Color_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            VStack {
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
                Color.PB1
                Color.PB2
                Color.PB3
                Color.PB4
                Color.TG1
                Color.TG2
                Color.TPB
            }
        }
        .padding()
    }
}

