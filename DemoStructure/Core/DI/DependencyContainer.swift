//
//  DependencyContainer.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 28/4/25.
//

import Foundation
import SwiftUI

final class DependencyContainer {
    static let shared = DependencyContainer()

    private init() {}

    // MARK: - Core
    private(set) lazy var apiClient: APIClient = {
        return APIClient()
    }()
    
    // MARK: - HomeService
    private(set) lazy var homeService: HomeService = {
        return HomeService(apiClient: apiClient)
    }()
    
    // MARK: - Services
    private(set) lazy var postServince: PostService = {
        return PostService(apiClient: apiClient)
    }()

    // MARK: - ViewModels
    func makeHomeModel() -> HomeViewModel {
        return HomeViewModel(homeService: homeService, postService: postServince)
    }
}
