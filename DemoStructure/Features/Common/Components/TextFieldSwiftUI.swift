//
//  TextFieldSwiftUI.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 21/5/25.
//

import SwiftUI
import Combine

struct TextFieldSwiftUI: View {
 
    @Binding var text: String
    @State var isSecure: Bool = false
    @State var isFocused: Bool = false
    @State private var isSecureTextEntry: Bool = false
    var plachoder: String = "Enter password"
    var isRequired: Bool = true
    var errorText: String = ""
    var height: CGFloat = 62
    var leadingIcon: ImageResource?
    var keyboardType: UIKeyboardType = .default
  
    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 0) {
                    if let icon = leadingIcon {
                        Image(icon)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.leading, 20)
                    }
                    VStack(spacing: 0) {
                        if text.isEmpty == false {
                            HStack {
                                TextSwiftUI(title: plachoder, color: Color.commonGray, lineLimit: 1)
                                if isRequired {
                                    TextSwiftUI(title: "*", color: Color.red, lineLimit: 1)
                                }
                                Spacer()
                            }
                            .frame(height: 31)
                            .padding(.horizontal, leadingIcon == nil ? 20 : 10)
                        }

                        TextFieldUIKitWrapper(text: $text,
                                              isFocused: $isFocused,
                                              isSecureTextEntry: $isSecureTextEntry,
                                              placeholder: plachoder)
                            .frame(height: 31)
                            .padding(.horizontal, leadingIcon == nil ? 20 : 10)
                            .padding(.top, text.isEmpty ? 0 : -5)
                    }
                    
                    if isSecure {
                        Button {
                            isSecureTextEntry.toggle()
                        } label: {
                            Image(systemName: isSecureTextEntry ? "eye.slash.fill" : "eye")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 20, height: 16)
                                .padding(.trailing, 20)
                        }
                    }
                }
                .frame(height: height)
            }
            .background(Color.commonGray.opacity(0.1))
            .cornerRadius(16)
            .overlay(
                ZStack {
                    if !errorText.isEmpty {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.red, lineWidth: 1)
                    } else if isFocused {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gradientBorderTextField, lineWidth: 1)
                    }
                }
            )
            
            if errorText.isEmpty == false {
                HStack {
                    TextSwiftUI(title: errorText, color: .red, weight: .bold)
                    Spacer()
                }
            }
        }
    }
}
