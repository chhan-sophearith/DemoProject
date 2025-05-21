//
//  LoginView.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 21/5/25.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel = DependencyContainer.shared.makeLoginViewModel()
    
    var body: some View {
        ZStack {
            Color.gradientLoginBackground.edgesIgnoringSafeArea(.all)
            VStack {
                Image(.wingbanklogo)
                    .resizable()
                    .frame(width: 220, height: 64)
                TextSwiftUI(title: "Welcome", weight: .italic)
                TextSwiftUI(title: "Loan Origination System", size: .large, weight: .bold)

                VStack {
                    VStack {
                        HStack {
                            TextSwiftUI(title: "Sign In", size: .large, weight: .bold)
                             Spacer()
                        }
                        TextFieldSwiftUI(text: $viewModel.username,
                                         plachoder: "Username",
                                         leadingIcon: .usernameIc)
                            .padding(.top, 20)
                          
                        TextFieldSwiftUI(text: $viewModel.password,
                                         isSecure: true,
                                         plachoder: "Password",
                                         leadingIcon: .passwordIc)
                            .padding(.top, 5)
                        
                        Button {
                            viewModel.isLoading = true
                        } label: {
                            ZStack {
                                if viewModel.isValid() {
                                    Color.commonGreen
                                } else {
                                    Color.light
                                }
                                if viewModel.isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                } else {
                                    TextSwiftUI(title: "Sign In",
                                                size: .medium,
                                                color: viewModel.isValid() ? Color.white : Color.commonGray)
                                }
                            }
                            .cornerRadius(16)
                            .frame(height: 47)
                        }
                        .padding(.top, 20)
                        
                        Button {
                           
                        } label: {
                            TextSwiftUI(title: "Forgot Password",
                                        size: .medium,
                                        color: Color.blue)
                        }
                        .padding(.vertical, 20)
                    }
                    .padding(25)
                }
                .background(Color.white)
                .cornerRadius(28)
            }
            .frame(width: UIScreen.width * 0.4)
        }
    }
}
