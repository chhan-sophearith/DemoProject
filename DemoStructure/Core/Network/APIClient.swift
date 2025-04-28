//
//  APIClient.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 25/4/25.
//
import SwiftUI

class APIClient: NSObject {
    
    func performRequest<T: Codable>(request: RequestBuilderProtocol,
                                callBack: @escaping (T) -> Void,
                                errorCallBack: ((BaseModel?) -> Void)? = nil) {
        if Reachability.isConnectedToNetwork() {
            let newRequest = validateRequestApi(reguest: request)
            // request to api
            let task = URLSession.shared.dataTask(with: newRequest, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error as NSError? {
                        switch error.code {
                        case NSURLErrorCannotFindHost:
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                LoadingView.shared.hide()
                                errorCallBack?(nil)
                             //   self.internet = false
                            }
                        case NSURLErrorTimedOut, NSURLErrorCannotConnectToHost:
                            LoadingView.shared.hide()
                          //  Utilize.shared.timeOut()
                            errorCallBack?(nil)
                        default:
                            LoadingView.shared.hide()
                            errorCallBack?(nil)
                          //  Utilize.shared.somethingWentWrong()
                        }
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        LoadingView.shared.hide()
                        print("status code ==>:", httpResponse.statusCode)
                        switch httpResponse.statusCode {
                        case (200...204):
                            Utilize.shared.debugger(urlRequest: newRequest, data: data, error: false)
                            Utilize.shared.validateModel(model: T.self, data: data, url: newRequest.url?.absoluteString) { objectData in
                                callBack(objectData)
                            }
                        case 401:
                            Utilize.shared.debugger(urlRequest: newRequest, data: data, error: true)
                            Utilize.shared.validateModel(model: BaseModel.self, data: data) { objectData in
                                errorCallBack?(nil)
                            }
                        case 422:
                            Utilize.shared.debugger(urlRequest: newRequest, data: data, error: true)
                            Utilize.shared.validateModel(model: BaseModel.self, data: data) { objectData in
                                errorCallBack?(nil)
                            }
                        case (500...503):
                            Utilize.shared.debugger(urlRequest: newRequest, data: data, error: true)
                            errorCallBack?(nil)
                           // Utilize.shared.serverError()
                        default:
                            Utilize.shared.debugger(urlRequest: newRequest, data: data, error: true)
                            errorCallBack?(nil)
                            // Utilize.shared.serverError()
                        }
                    }
                }
            })
            task.resume()
        }
    }
}

extension APIClient {
    
    private func validateRequestApi(reguest: RequestBuilderProtocol) -> URLRequest {
        if reguest.isLoading {
            LoadingView.shared.show()
        }
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest()
        urlRequest.httpMethod = reguest.method.rawValue
        
        var strUrl = URL(string: BaseUrls.url + reguest.endpoint.path)
        urlRequest.url = strUrl
        
        if reguest.method == .GET, let parameters = reguest.parameters {
            var components = URLComponents(string: BaseUrls.url + reguest.endpoint.path)!
            var queryParams: [URLQueryItem] = []
            for (key, value) in parameters {
                queryParams.append(URLQueryItem(name: key, value: "\(value)"))
            }
            components.queryItems = queryParams
            strUrl = components.url
            urlRequest.url = components.url
        } else {
            do {
                if let param = reguest.parameters {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: param, options: [])
                }
            } catch let error as NSError {
                print("error", error.localizedDescription)
            }
        }

        // add headers
        let token = ""
        if reguest.header != nil && token.isEmpty == false {
           
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var newRequest = urlRequest as URLRequest
        newRequest.timeoutInterval = 90.0
        return newRequest
    }
    
    private func createURLWithQueryParameters(baseUrl: String, path: String, method: HTTPMethod, param: Parameters?) -> URL? {
        if method == .GET, let param {
            var components = URLComponents(string: baseUrl + path)!
            var queryParams: [URLQueryItem] = []
            for (key, value) in param {
                queryParams.append(URLQueryItem(name: key, value: "\(value)"))
            }
            components.queryItems = queryParams
            return components.url
        }
        return nil
    }
}
