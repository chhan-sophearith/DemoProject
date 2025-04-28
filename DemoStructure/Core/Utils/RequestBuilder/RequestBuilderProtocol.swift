//
//  RequestBuilderProtocol.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 28/4/25.
//

import Foundation
import SwiftUI

protocol RequestBuilderProtocol {
    var endpoint: Endpoints { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var header: HTTPHeaders? { get }
    var isMockEndPoint: Bool { get }
    var isLoading: Bool { get }
}
