//
//  Utilize.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 26/4/25.
//

import SwiftUI

class Utilize {
    
    static let shared = Utilize()
    
    func debugger(urlRequest: URLRequest, data: Data?, error: Bool) {
        #if DEBUG
        let url = urlRequest.url!
        let strurl = url.absoluteString
        print("strurl ==>", strurl)
        let allHeaders =  urlRequest.allHTTPHeaderFields ?? [:]
        let body = urlRequest.httpBody.flatMap { String(data: $0, encoding: .utf8) }
        let result = """
              ⚡️⚡️⚡️⚡️ Headers: \(String(describing: allHeaders))
              ⚡️⚡️⚡️⚡️ Request Body: \(String(describing: body ?? nil))
        """
        print(result)
        
        let newData = data ?? Data()
               
        do {
            guard let json = try JSONSerialization.jsonObject(with: newData, options: []) as? [String: AnyObject] else {
                if let arrayObject = try JSONSerialization.jsonObject(with: newData, options: []) as? [AnyObject] {
                    self.formatArrayAnyObject(json: arrayObject, url: strurl, error: error)
                }
                return
            }
            self.formatDictionay(json: json, url: strurl, error: error)
        } catch {
            if let newData = data, let str = String(data: newData, encoding: .utf8) {
                printerFormat(url: strurl, data: str, error: true)
            }
        }
        #endif
    }
    
    private func printerFormat(url: String, data: String, error: Bool) {
        let printer = """
        URL -->: \(url)
        Response Received -->: \(data)
        """
        
        if error {
            print("❌❌❌❌ \(printer) ❌❌❌❌")
        } else {
            print("✅✅✅✅ \(printer) ✅✅✅✅")
        }
    }
    
    private func formatArrayAnyObject(json: [AnyObject], url: String, error: Bool) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else { return }
        let data = "\(NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? NSString())"
        self.printerFormat(url: url, data: data, error: error)
    }
    
    private func formatDictionay(json: [String: AnyObject], url: String, error: Bool) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else { return }
        let data = "\(NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? NSString())"
        self.printerFormat(url: url, data: data, error: error)
    }
    
    func validateModel<T: Codable>(model: T.Type, data: Data?, url: String? = "", response: (T) -> Void) {
        do {
            if let newData = data {
                let json = try JSONDecoder().decode(T.self, from: newData)
                response(json)
            }
        } catch let DecodingError.typeMismatch(type, context) {
            print(type, context)
          //  let endPoint = "⚡️URL -->: " + (url ?? "") + "⚡️"
            
          //  self.validateShowMessage(message: context.showError(functionName: endPoint))
        } catch let error {
            print(error)
           // self.validateShowMessage(message: error.localizedDescription)
        }
    }
}
