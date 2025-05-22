//
//  CenterView.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 22/5/25.
//

import SwiftUI

struct CenterView: View {
    
    @ObservedObject var viewModel: LoanViewModel
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                VStack(spacing: 20) {
                    if let data = viewModel.loanTypes?.data {
                        ForEach(data[viewModel.loanTypeIndex].sections.indices, id: \.self) { index in
                            FormExtendView(title: data[viewModel.loanTypeIndex].sections[index].section, isExtend: viewModel.indexSelected == index) {
                                if viewModel.indexSelected == index {
                                    DynamicFormView(data: $viewModel.loanTypes, loanTypeIndex: viewModel.loanTypeIndex)
                                }
                            }
                            .onTapGesture {
                                if viewModel.indexSelected == index {
                                    viewModel.indexSelected = -1
                                } else {
                                    viewModel.indexSelected = index
                                }
                            }
                        }
                    }
                }
            }
            .padding(.top, 20)
            .padding(.leading, 20)
        }
    }
}
