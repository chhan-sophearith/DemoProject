//
//  BaseUrls.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 25/4/25.
//

import SwiftUI

struct BaseUrls {
    
    static var url: String {
        #if Dev
            return "https://jsonplaceholder.typicode.com"
        #elseif UAT
            return "https://jsonplaceholder.typicode.com"
        #elseif SIT
            return "https://jsonplaceholder.typicode.com"
        #else
            return "https://jsonplaceholder.typicode.com"
        #endif
    }

    static var name: String {
        #if Dev
        return "Dev (\(Constant.appBuildNumber ?? ""))"
        #elseif UAT
        return "UAT (\(Constant.appBuildNumber ?? ""))"
        #elseif SIT
        return "SIT (\(Constant.appBuildNumber ?? ""))"
        #else
            return ""
        #endif
    }
}
