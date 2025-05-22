//
//  LoanView.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 22/5/25.
//

import SwiftUI

struct LoanView: View {
    var body: some View {
        DynamicFormView()
    }
}

func loadJSON<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename): \(error)")
    }
}

struct DynamicFormView: View {
    @State private var data: FormModel?

    var body: some View {
        ScrollView {
            if var newData = data {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(Array(newData.sections.enumerated()), id: \.1.section) { sectionIndex, section in
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

                                            fieldView(
                                                field: Binding(
                                                    get: {
                                                        newData.sections[sectionIndex].content[contentIndex].fields[fieldIndex]
                                                    },
                                                    set: { newField in
                                                        newData.sections[sectionIndex].content[contentIndex].fields[fieldIndex] = newField
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
        .onAppear {
            self.data = loadJSON("LoanForm", as: FormModel.self)
        }
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

struct FormModel: Codable {
    var sections: [SectionModel]
}

struct SectionModel: Codable {
    let section: String
    var content: [ContentModel]
}

struct ContentModel: Codable {
    let title: String
    var fields: [FieldModel]
}

struct FieldModel: Codable {
    let id: String
    let label: String
    let type: FieldType
    let options: [String]?
    let rules: [String: Bool]
    var values: [String]
    var value: String
}

enum FieldType: String, Codable {
    case text
    case multiSelect = "multi_select"
    case singleSelect = "single_select"
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let raw = try container.decode(String.self)
        self = FieldType(rawValue: raw) ?? .unknown
    }
}
