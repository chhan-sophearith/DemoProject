//
//  Font.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 28/4/25.
//

import SwiftUI

extension Font {
    static func customFont(size: CGFloat,
                           weight: FontName = .regular) -> Font {
        return Font.custom(weight.name, size: size)
    }
}
