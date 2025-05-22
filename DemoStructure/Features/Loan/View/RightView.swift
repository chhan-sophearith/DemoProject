//
//  RightView.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 22/5/25.
//

import SwiftUI

struct RightView: View {
    @Binding var loanTypeIndex: Int
    @State private var showDropdown = false
    @State private var showDropdown2 = false
    @State private var selectedLoanType = "Housing Loan"
     
    let loans: LoanTypeModel?
    
    var body: some View {
        ZStack {
            Color.commonBackground.edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                VStack {
                    loanInfoView
                    ForEach(0..<100) { index in
                        Text("Index \(index)")
                    }
                }
                .padding(.trailing, 25)
                .padding(.leading, 20)
            }
        }
    }
    
    var loanInfoView: some View {
        VStack {
            Button {
                withAnimation {
                    showDropdown2.toggle()
                }
            } label: {
                VStack {
                    VStack {
                        HStack {
                            TextSwiftUI(title: "Loan Info", size: .medium, weight: .bold)
                            Spacer()
                        }
                        .padding(.horizontal, 25)
                        
                        laonType
                        laonRange
                            .padding(.top, 10)
                    }
                    .padding(.vertical, 15)
                }
                .background(Color.white)
                .cornerRadius(16)
                .padding(.top, 20)
            }
        }
        .popover(isPresented: $showDropdown2) {
            if let loans = loans {
                VStack(alignment: .leading) {
                    ForEach(loans.data.indices, id: \.self) { index in
                        Button("\(loans.data[index].loanType)") {
                            loanTypeIndex = index
                            selectedLoanType = loans.data[index].loanType
                            showDropdown = false
                        }
                    }
                }
                .padding()
                .frame(width: 200)
            }
        }
    }
    
    var laonType: some View {
        ZStack {
            Color.commonBackground
            if let loans = loans {
                Button {
                    // show drop down
                    withAnimation {
                        showDropdown.toggle()
                    }
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                TextSwiftUI(title: "Loan Type", color: .commonGray)
                                TextSwiftUI(title: "*", color: .red)
                            }
                            TextSwiftUI(title: loans.data[loanTypeIndex].loanType, size: .medium)
                        }
                        Spacer()
                        Image(.thinArrowDownIc)
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                }
            }
        }
        .cornerRadius(16)
        .padding(.horizontal, 25)
        .popover(isPresented: $showDropdown) {
            if let loans = loans {
                VStack(alignment: .leading) {
                    ForEach(loans.data.indices, id: \.self) { index in
                        Button("\(loans.data[index].loanType)") {
                            loanTypeIndex = index
                            selectedLoanType = loans.data[index].loanType
                            showDropdown = false
                        }
                    }
                }
                .padding()
                .frame(width: 200)
            }
        }
    }
    
    var laonRange: some View {
        ZStack {
            Color.commonBackground
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        TextSwiftUI(title: "Loan Range", color: .commonGray)
                        TextSwiftUI(title: "*", color: .red)
                    }
                    TextSwiftUI(title: "</30k", size: .medium)
                }
                Spacer()
                Image(.thinArrowDownIc)
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
        }
        .cornerRadius(16)
        .padding(.horizontal, 25)
    }
}
