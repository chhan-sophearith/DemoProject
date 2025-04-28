//
//  Endpoints.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 25/4/25.
//

import SwiftUI

enum Endpoints {
    case getUsers
    case createPost
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .createPost:
            return "/posts"
        }
    }
}
