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
                DynamicFormView(data: $viewModel.loanTypes, loanTypeIndex: viewModel.loanTypeIndex)
                Spacer()
                RightView()
                    .frame(width: UIScreen.width * 0.2)
            }
        }
        .background(Color.commonBackground)
        .onAppear {
           // viewModel.loanTypes?.data
            viewModel.loanTypes = viewModel.loadJSON("LoanForm", as: LoanTypeModel.self)
        }
    }
}

struct RightView: View {
    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    ForEach(0..<100) { index in
                        Text("Index \(index)")
                    }
                }
            }
        }
       // .background()
        
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
                                Text(section.section)
                                    .font(.title2)
                                    .bold()
                                
                                ForEach(Array(section.content.enumerated()), id: \.1.title) { contentIndex, content in
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(content.title)
                                            .font(.headline)
                                            .padding(.leading, 20)
                                        
                                        ForEach(Array(content.fields.enumerated()), id: \.1.id) { fieldIndex, field in
                                            VStack(alignment: .leading, spacing: 6) {
                                                Text(field.label)
                                                    .font(.subheadline)
                                                    .padding(.leading, 40)
                                                
                                              //  Text("Type \(field.type)")
                                               
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
            Picker(selection: field.value, label: Text("Select")) {
                ForEach(field.wrappedValue.options ?? [], id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
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
            
        default:
            EmptyView()
        }
    }
}
