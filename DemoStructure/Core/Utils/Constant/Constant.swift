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
    
    static var envName: String {
        #if DEV
        return "DEV (\(Constant.appBuildNumber ?? ""))"
        #elseif UAT
        return "UAT (\(Constant.appBuildNumber ?? ""))"
        #elseif SIT
        return "SIT (\(Constant.appBuildNumber ?? ""))"
        #else
            return ""
        #endif
    }
}
