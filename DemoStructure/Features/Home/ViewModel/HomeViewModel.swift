//
//  HomeViewModel.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 25/4/25.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    private var homeService: HomeService
    private var postService: PostService
    @Published var currentLanguage: String = UserDefault.shared.getLanguangeCode()
    @Published var text = "hello"
    @Published var users: [User] = []
    @Published var posts: [Post] = []
    @Published var isNavigate: Bool = false
    
    init(homeService: HomeService, postService: PostService) {
        self.homeService = homeService
        self.postService = postService
    }

    func changeLang(code: String) {
        UserDefault.shared.setLanguageCode(with: code)
        currentLanguage = code
    }
    
    func getUsers() {
        self.homeService.getUsers { users in
            self.users = users
        }
    }
    
    func createPost() {
        self.postService.createPost(title: randomString(length: 10), body: randomString(length: 60)) { post in
            self.posts.append(post)
        }
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).compactMap { _ in letters.randomElement() })
    }
}
