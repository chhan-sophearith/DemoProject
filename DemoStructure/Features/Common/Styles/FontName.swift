//
//  FontName.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 28/4/25.
//

import Foundation

enum FontName {
    case regular
    case thin
    case light
    case extraLight
    case medium
    case semiBold
    case bold
    case extraBold
    case black
    case other(String)
    
    var name: String {
        switch self {
        case .regular:
            return "Lexend-Regular"
        case .thin:
            return "Lexend-Thin"
        case .extraLight:
            return "Lexend-ExtraLight"
        case .light:
            return "Lexend-Light"
        case .medium:
            return "Lexend-Medium"
        case .semiBold:
            return "Lexend-SemiBold"
        case .bold:
            return "Lexend-Bold"
        case .extraBold:
            return "Lexend-ExtraBold"
        case .black:
            return "Lexend-Black"
        default:
            return "Lexend-Regular"
        }
    }
}
