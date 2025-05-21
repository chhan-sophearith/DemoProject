//
//  LoginViewModel.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 21/5/25.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password  = ""
    @Published var isLoading  = false
    
    func isValid() -> Bool {
        if username.isEmpty {
            return false
        } else if password.isEmpty {
            return false
        } else {
            return true
        }
    }
}
