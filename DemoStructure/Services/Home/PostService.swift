//
//  PostService.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 28/4/25.
//

import Foundation

struct PostBuilder: JSONRequestBuilderProtocol {

    let request: PostRequest

    init(with request: PostRequest) {
        self.request = request
    }

    var parameters: Parameters? {
        return request.parameters
    }

    var endpoint: Endpoints {
        return .createPost
    }

    var method: HTTPMethod {
        return .POST
    }

    var header: HTTPHeaders? {
        return nil
    }

    var isMockEndPoint: Bool {
        return false
    }
    
    var isLoading: Bool {
        return true
    }
}

class PostService {
    
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func createPost(title: String, body: String, completion: @escaping (_ post: Post) -> Void) {
        let postRequest = PostRequest(title: title, body: body)
        let apiRequest = PostBuilder(with: postRequest)
        self.apiClient.performRequest(request: apiRequest) { (data: Post) in
            completion(data)
        }
    }
}
