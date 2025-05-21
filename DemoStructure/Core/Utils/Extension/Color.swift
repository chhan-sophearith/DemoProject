//
//  Color.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 20/5/25.
//

import SwiftUI

extension Color {

    static let gradientNavigationBar = LinearGradient(
        gradient: Gradient(colors: [
            Color(hex: "C6E5FF"),
            Color(hex: "B9D9FE"),
            Color(hex: "CBCBFF")
        ]),
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let gradientLoginBackground = LinearGradient(
        gradient: Gradient(colors: [
            Color(hex: "D2E0A1"),
            Color(hex: "D2F7FF"),
            Color(hex: "66AEFF")
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let gradientBorderTextField = LinearGradient(
        gradient: Gradient(colors: [
            Color(hex: "D2E0A1"),
            Color(hex: "D2F7FF"),
            Color(hex: "66AEFF")
        ]),
        startPoint: .leading,
        endPoint: .trailing
    )
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff
        )
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
