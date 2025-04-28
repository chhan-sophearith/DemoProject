//
//  String.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 25/4/25.
//

import SwiftUI

extension String {

    var localize: String {
        let code = UserDefault.shared.getLanguangeCode()
        return localized(code: code)
    }

    private func localized(code: String = "en") -> String {

        guard let bundlePath = Bundle.main.path(forResource: code, ofType: "lproj") else {
            return self
        }

        let languageBundle = Bundle(path: bundlePath)

        guard let translatedText = languageBundle?.localizedString(forKey: self, value: "", table: nil) else {
            return ""
        }
        return translatedText
    }
}
