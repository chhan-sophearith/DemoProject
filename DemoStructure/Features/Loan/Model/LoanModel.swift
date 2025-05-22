//
//  LoanModel.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 22/5/25.
//

import Foundation
import SwiftUI

struct LoanTypeModel: Codable {
    var data: [FormModel]
}

struct FormModel: Codable {
    let loanType: String
    var sections: [SectionModel]
}

struct SectionModel: Codable {
    let sectionId: String
    let section: String
    var content: [ContentModel]
    
    enum CodingKeys: String, CodingKey {
        case sectionId = "section_id"
        case section
        case content
    }
}

struct ContentModel: Codable {
    let contentId: String
    let title: String
    var fields: [FieldModel]
    
    enum CodingKeys: String, CodingKey {
        case contentId = "content_id"
        case title
        case fields
    }
}

struct FieldModel: Codable {
    let id: String
    let label: String
    let type: FieldType
    let options: [String]?
    let rules: Rules?
    var value: String
    var values: [String]
}

struct Rules: Codable {
    let required: Bool
}

enum FieldType: String, Codable {
    case text
    case multiSelect = "multi_select"
    case singleSelect = "single_select"
    case date
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let raw = try container.decode(String.self)
        self = FieldType(rawValue: raw) ?? .unknown
    }
}
