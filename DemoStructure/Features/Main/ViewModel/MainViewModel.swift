//
//  MainViewModel.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 20/5/25.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var tabIndex: Int = 0
    
    let mainTabList: [TabItemModel] = [
        .init(icon: .dashboardIc, title: "Dashboard"),
        .init(icon: .loanIc, title: "Loan"),
        .init(icon: .accountIc, title: "Account"),
        .init(icon: .merchantIc, title: "Merchant"),
        .init(icon: .agentIc, title: "Agent"),
        .init(icon: .surveyIc, title: "Survey"),
        .init(icon: .calculatorIc, title: "Calculator"),
    ]
}
