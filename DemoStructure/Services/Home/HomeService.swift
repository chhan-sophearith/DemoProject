//
//  HomeService.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 26/4/25.
//

import Foundation
import SwiftUI

struct HomeBuilder: JSONRequestBuilderProtocol {
    
    var params: Parameters? {
        return nil
    }

    var endpoint: Endpoints {
        return .getUsers
    }

    var method: HTTPMethod {
        return .GET
    }

    var header: HTTPHeaders? {
        return nil
    }

    var isMockEndPoint: Bool {
        return false
    }
    
    var isLoading: Bool {
        return false
    }
}

class HomeService {
    
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getUsers(completion: @escaping (_ users: [User]) -> Void) {
        let request = HomeBuilder()
        
        self.apiClient.performRequest(request: request) { (data: [User]) in
            completion(data)
        }
    }
}
