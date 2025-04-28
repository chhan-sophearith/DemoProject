//
//  TextSwiftUI.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 28/4/25.
//

import Foundation
import SwiftUI

struct TextSwiftUI: View {
    var title: String
    var size: FontSize = .normal
    var color: Color = .commonText
    var weight: FontName = .regular
    var textAlignment: TextAlignment = .leading
    var isUnderline: Bool?
    var lineLimit: Int?
    var gradientColor: LinearGradient?
    
    var body: some View {
        Text(title)
            .underline(isUnderline ?? false, color: color)
            .foregroundColor(gradientColor == nil ? color : Color.clear)
            .font(.customFont(size: size.fontSize, weight: weight))
            .fixedSize(horizontal: false, vertical: true)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(textAlignment)
            .lineLimit(lineLimit)
//            .overlay {
//                gradientColor
//            }
            .mask(
                Text(title)
                    .font(.customFont(size: size.fontSize, weight: weight))
                    .underline(isUnderline ?? false, color: color)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(textAlignment)
            )
    }
}
