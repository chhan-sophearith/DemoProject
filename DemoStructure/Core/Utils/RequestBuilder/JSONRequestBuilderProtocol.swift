//
//  JSONRequestBuilderProtocol.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 28/4/25.
//

import Foundation

protocol JSONRequestBuilderProtocol: RequestBuilderProtocol { }

extension JSONRequestBuilderProtocol {
    
    var method: HTTPMethod {
        return .GET
    }

    var parameters: Parameters? {
        return nil
    }

    var header: HTTPHeaders? {
        return nil
    }

    var isMockEndPoint: Bool? {
        return false
    }
    
    var isLoading: Bool? {
        return false
    }
}
