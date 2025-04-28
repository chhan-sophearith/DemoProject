//
//  Constant.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 25/4/25.
//

import SwiftUI

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]
public typealias JSONDictionary = [String: Any]

enum HTTPMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
    case PATCH
}

class Constant {
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    static let appBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
}
