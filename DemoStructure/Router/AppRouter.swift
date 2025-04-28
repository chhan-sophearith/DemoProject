//
//  AppRouter.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 28/4/25.
//

import Foundation
import SwiftUI

enum Screen {
    case login
    case dashboard
    case second
    case none
}

class AppRouter: ObservableObject {
    
    @Published var currentScreen: Screen = .none
    @Published var isNavigate: Bool = false
    
    func navigateToScreen(screen: Screen) {
        currentScreen = screen
    }
}
