//
//  FontSize.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 28/4/25.
//

import Foundation
import SwiftUI

enum FontSize {
    case small
    case normal
    case medium
    case large
    case huge
    case other(CGFloat)

    var fontSize: CGFloat {
        switch self {
        case .small:
            return 12
        case .normal:
            return 14
        case .medium:
            return 16
        case .large:
            return 20
        case .huge:
            return 22
        case .other(let customSize):
            return customSize
        }
    }
}
