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
                Spacer()
                ScrollView {
                    VStack(spacing: 20) {
                        if let data = viewModel.loanTypes?.data {
                            
                            ForEach(data[viewModel.loanTypeIndex].sections.indices, id: \.self) { index in
                                ExtendView(title: data[viewModel.loanTypeIndex].sections[index].section, isExtend: viewModel.indexSelected == index) {
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

struct ExtendView<Content: View>: View {
    let title: String
    let content: Content
    var isExtend: Bool = false

    init(title: String, isExtend: Bool, @ViewBuilder content: () -> Content) {
        self.title = title
        self.isExtend = isExtend
        self.content = content()
    }

    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(16)
            VStack {
                HStack {
                    HStack {
                        Image(.defaultCheckIc)
                            .resizable()
                            .frame(width: 28, height: 28)
                        TextSwiftUI(title: title, size: .large, weight: .bold)
                            .padding(.leading, 10)
                    }
                    
                    Spacer()
                    
                    Image(isExtend ? .extendArrowUp : .extendArrowDown)
                        .frame(width: 28, height: 28)
                }
                .padding(25)
                content
                    .padding()
            }
        }
    }
}

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

struct LoanTypeDropDownView: View {
    
    @Binding var showDropdown: Bool
    @Binding var selectedLoanType: String
    let loanTypes: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(loanTypes, id: \.self) { type in
                Button {
                    selectedLoanType = type
                    withAnimation {
                        showDropdown = false
                    }
                } label: {
                    Text(type)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(selectedLoanType == type ? Color.gray.opacity(0.2) : Color.clear)
                }
            }
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 2)
        .padding(.horizontal, 25)
        .transition(.opacity.combined(with: .move(edge: .top)))
    }
}

struct DynamicFormView: View {
    @Binding var data: LoanTypeModel?
    var loanTypeIndex: Int = 0
    
    var body: some View {
        VStack {
            ScrollView {
                if var newData = data {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(Array(newData.data[loanTypeIndex].sections.enumerated()), id: \.1.section) { sectionIndex, section in
                            VStack(alignment: .leading, spacing: 15) {
                                ForEach(Array(section.content.enumerated()), id: \.1.title) { contentIndex, content in
                                    VStack(alignment: .leading, spacing: 10) {
                        
                                        TextSwiftUI(title: "\(content.title)", size: .huge, weight: .bold)
                                            .padding(.leading)
                                        
                                        ForEach(Array(content.fields.enumerated()), id: \.1.id) { fieldIndex, field in
                                            VStack(alignment: .leading, spacing: 6) {
                                                TextSwiftUI(title: "\(field.label)", weight: .bold)
                                                    .padding(.leading)
                                            
                                                fieldView(
                                                    field: Binding(
                                                        get: {
                                                            newData.data[loanTypeIndex].sections[sectionIndex].content[contentIndex].fields[fieldIndex]
                                                        },
                                                        set: { newField in
                                                            newData.data[loanTypeIndex].sections[sectionIndex].content[contentIndex].fields[fieldIndex] = newField
                                                        }
                                                    )
                                                )
                                                .padding(.leading, 40)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .background(Color.white)
    }

    @ViewBuilder
    func fieldView(field: Binding<FieldModel>) -> some View {
        switch field.wrappedValue.type {
        case .text:
            TextField("Enter \(field.wrappedValue.label)", text: field.value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
        case .singleSelect:
            VStack(alignment: .leading) {
                ForEach(field.wrappedValue.options ?? [], id: \.self) { option in
                    HStack {
                        Image(systemName: field.value.wrappedValue == option ? "largecircle.fill.circle" : "circle")
                            .foregroundColor(.blue)
                        Text(option)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        field.value.wrappedValue = option
                    }
                    .padding(.vertical, 4)
                }
            }
            
        case .multiSelect:
            VStack(alignment: .leading) {
                ForEach(field.wrappedValue.options ?? [], id: \.self) { option in
                    Toggle(isOn: Binding(
                        get: {
                            field.values.wrappedValue.contains(option)
                        },
                        set: { isOn in
                            var newValues = field.values.wrappedValue
                            if isOn {
                                newValues.append(option)
                            } else {
                                newValues.removeAll { $0 == option }
                            }
                            field.values.wrappedValue = newValues
                        }
                    )) {
                        Text(option)
                    }
                }
            }
        case .date:
            TextField("Enter \(field.wrappedValue.label)", text: field.value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        default:
            EmptyView()
        }
    }
}
