//
//  DynamicFormView.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 22/5/25.
//

import SwiftUI

struct DynamicFormView: View {
    @Binding var data: LoanTypeModel?
    var loanTypeIndex: Int = 0
    
    var body: some View {
        VStack {
            if var newData = data {
                VStack(alignment: .leading) {
                    ForEach(Array(newData.data[loanTypeIndex].sections.enumerated()), id: \.1.section) { sectionIndex, section in
                        VStack(alignment: .leading, spacing: 15) {
                            ForEach(Array(section.content.enumerated()), id: \.1.title) { contentIndex, content in
                                VStack(alignment: .leading) {
                                    TextSwiftUI(title: "\(content.title)", size: .medium, weight: .bold)
                                      //  .padding(.leading)
                                    Divider()
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
                .padding(.top, 10)
                .padding(.horizontal, 25)
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
