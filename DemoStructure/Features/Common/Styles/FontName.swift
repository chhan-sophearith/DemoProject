//
//  FontName.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 28/4/25.
//

import Foundation

enum FontName {
    case extraLight
    case regular
    case light
    case medium
    case bold
    case semiBold
    case extraBold
    case extraLightItalic
    case lightItalic
    case italic
    case mediumItalic
    case semiBoldItalic
    case extraBoldItalic
    case boldItalic
    case other(String)
    
    var name: String {
        switch self {
        case .extraLight:
            return "PlusJakartaSans-ExtraLight"
        case .regular:
            return "PlusJakartaSans-Regular"
        case .light:
            return "PlusJakartaSans-Light"
        case .medium:
            return "PlusJakartaSans-Medium"
        case .semiBold:
            return "PlusJakartaSans-SemiBold"
        case .bold:
            return "PlusJakartaSans-Bold"
        case .extraBold:
            return "PlusJakartaSans-ExtraBold"
        case .extraLightItalic:
            return "PlusJakartaSans-ExtraLightItalic"
        case .lightItalic:
            return "PlusJakartaSans-LightItalic"
        case .italic:
            return "PlusJakartaSans-Italic"
        case .mediumItalic:
            return "PlusJakartaSans-MediumItalic"
        case .semiBoldItalic:
            return "PlusJakartaSans-SemiBoldItalic"
        case .extraBoldItalic:
            return "PlusJakartaSans-ExtraBoldItalic"
        case .boldItalic:
            return "PlusJakartaSans-BoldItalic."
        case .other(let fontName):
            return fontName
        }
    }
}
