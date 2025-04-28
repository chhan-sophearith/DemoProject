//
//  BaseModel.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 25/4/25.
//

struct BaseModel: Codable {
    let status: String
}

struct APIRequest {
    let resource: Endpoints
    let method: HTTPMethod
    var parameters: Parameters?
    var header: Bool = false
    var isLoading: Bool = true
}
