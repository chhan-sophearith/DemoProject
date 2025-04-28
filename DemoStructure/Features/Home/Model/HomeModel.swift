//
//  HomdeModel.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 28/4/25.
//

import Foundation
import SwiftUI

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo

    enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geo
    }
}

struct Geo: Codable {
    let lat: String
    let lng: String

    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String

    enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case bs
    }
}

struct Post: Codable {
    let title: String
    let body: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case title
        case body
        case id
    }
}
