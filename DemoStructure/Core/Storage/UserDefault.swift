//
//  UserDefaults.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 25/4/25.
//

import SwiftUI

class UserDefault {

    static let shared = UserDefault()
    private var defaults: UserDefaults = UserDefaults.standard
    let selectedLanguage = "languageKey"
    
    func setLanguageCode(with code: String) {
        defaults.set(code, forKey: selectedLanguage)
        defaults.synchronize()
    }

    func getLanguangeCode() -> String {
        guard let language = defaults.object(forKey: selectedLanguage) as? String else {
            return "en"
        }
        return language
    }
}
