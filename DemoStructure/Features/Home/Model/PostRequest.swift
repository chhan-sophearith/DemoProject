//
//  PostRequest.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 28/4/25.
//

import Foundation
import SwiftUI

struct PostRequest: Codable {
    var title: String
    var body: String

    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
    
    var parameters: Parameters? {
        return [
            "title": self.title,
            "body": self.body
        ]
    }
}
