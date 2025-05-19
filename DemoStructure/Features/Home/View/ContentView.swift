//
//  ContentView.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 25/4/25.
//

import SwiftUI

struct ContentView: View {
    
   // @ObservedObject var router = AppRouter()
    @ObservedObject private var viewModel = DependencyContainer.shared.makeHomeModel()
    
    var body: some View {
        VStack {
            Text("\(Constant.envName)")
            
            Button {
                viewModel.isNavigate.toggle()
            } label: {
                Text("Navigate ->")
            }
            TextSwiftUI(title: "Change Language", size: .large, weight: .bold)
            HStack {
                Button {
                    viewModel.changeLang(code: "en")
                } label: {
                    HStack {
                        Text("English")
                            .foregroundColor(.white)
                            .padding(5)
                    }
                    .background(Color.blue)
                }
                
                Button {
                    viewModel.changeLang(code: "km")
                } label: {
                    HStack {
                        Text("Khmer")
                            .foregroundColor(.white)
                            .padding(5)
                    }
                    .background(Color.blue)
                }
            }
            
            Text(viewModel.text.localize)
                .font(.title)
            Divider()
          
            Button {
                viewModel.createPost()
            } label: {
                HStack {
                    Text("Create Post")
                        .foregroundColor(.white)
                        .padding(5)
                }
                .background(Color.blue)
            }
            ScrollView {
                HStack {
                    Text("Posts List \(viewModel.posts.isEmpty == true ? "No Data" : "")")
                    Spacer()
                }
                VStack {
                    ForEach(viewModel.posts.indices, id: \.self) { index in
                        let post = viewModel.posts[index]
                        Divider()
                        HStack {
                            Text("Title:")
                            Text("\(post.title)")
                            Spacer()
                        }
                        HStack {
                            Text("body:")
                            Text("\(post.body)")
                            Spacer()
                        }
                    }
                }
                .padding(.top, 10)
                
                Divider()
                
                HStack {
                    Text("Users List")
                    Spacer()
                }
                VStack {
                    ForEach(viewModel.users.indices, id: \.self) { index in
                        let name = viewModel.users[index].name
                        HStack {
                            Text("Name:")
                            Text("\(name)")
                            Spacer()
                        }
                    }
                }
                .padding(.top, 10)
                Divider()
            }
        }
        .padding()
        .background(Color.white)
        .onAppear {
            viewModel.getUsers()
        }
        .background(
            NavigationLink("", destination: SecondView(), isActive: $viewModel.isNavigate)
        )
    }
}
