//
//  TextFieldUIKitWrapper.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 21/5/25.
//

import UIKit
import SwiftUI

struct TextFieldUIKitWrapper: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var isFocused: Bool
    @Binding var isSecureTextEntry: Bool
    var placeholder: String
   
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldUIKitWrapper
        
        init(_ parent: TextFieldUIKitWrapper) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.isFocused = true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.isFocused = false
        }
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecureTextEntry
        textField.delegate = context.coordinator
        textField.backgroundColor = .clear
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.adjustsFontSizeToFitWidth = false
        textField.minimumFontSize = 16
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.isSecureTextEntry = isSecureTextEntry
        if isFocused && !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        } else if !isFocused && uiView.isFirstResponder {
            uiView.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
