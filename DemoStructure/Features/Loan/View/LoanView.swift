//
//  LoanView.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 22/5/25.
//

import SwiftUI

struct LoanView: View {
    
    @ObservedObject var viewModel = DependencyContainer.shared.makeLoanViewModel()
    
    var body: some View {
        VStack {
            HStack {
                CenterView(viewModel: viewModel)
                Spacer()
                RightView(loanTypeIndex: $viewModel.loanTypeIndex, loans: viewModel.loanTypes)
                    .frame(width: UIScreen.width * 0.2)
            }
        }
        .background(Color.commonBackground)
        .onAppear {
            viewModel.loanTypes = viewModel.loadJSON("LoanForm", as: LoanTypeModel.self)
        }
    }
}
