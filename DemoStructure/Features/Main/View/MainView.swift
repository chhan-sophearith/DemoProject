//
//  MainView.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 20/5/25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var mainVM = MainViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                headerView
                
                HStack(spacing: 0) {
                    tabbarView
                    Spacer()
                    NavigationView {
                        switch mainVM.tabIndex {
                        case 0:
                            
                            NavigationLink {
                                EmptyView()
                            } label: {
                                Text("Tap ===")
                            }
                            
                        case 1:
                            Text("Hello world!")
                        case 2:
                            Text("welcome!")
                        case 3:
                            Text("Hi!")
                        default: EmptyView()
                        }
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                    Spacer()
                }
            }
        }
    }
    
    var headerView: some View {
        HStack(alignment: .top) {
            Image(.wingbanklogo)
                .padding(.horizontal, 25)
            Spacer()
            HStack(spacing: 25) {
                Spacer()
                
                HStack(spacing: 15) {
                    Image(.calenderIc)
                        .frame(width: 20, height: 20)
                    TextSwiftUI(title: "27 Mar, 2025", color: .white)
                }
                
                Button {
                    
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.darkBlue)
                            .frame(width: 32, height: 32)
                        Image(.bellIc)
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .frame(width: 32, height: 32)
                }
                .overlay(
                    VStack {
                        HStack {
                            Spacer()
                            ZStack {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 16, height: 16)
                                TextSwiftUI(title: "1", size: .small, color: .white)
                            }
                        }
                        .padding(.trailing, -10)
                        Spacer()
                    }
                )
                
                .frame(width: 32, height: 32)
                
                Button {
                    
                } label: {
                    HStack {
                        HStack {
                            Image(.enFlagIc)
                                .frame(width: 24, height: 18)
                            
                            TextSwiftUI(title: "EN", color: .white)
                        }
                        .frame(height: 32)
                        .padding(.horizontal, 10)
                    }
                    .background(Color.darkBlue)
                    .cornerRadius(48)
                    .frame(height: 32)
                }
                HStack(spacing: 15) {
                    Image(.testProfile)
                        .frame(width: 32, height: 32)
                    VStack(alignment: .leading) {
                        TextSwiftUI(title: "Jonh Son", size: .medium, color: .white)
                        TextSwiftUI(title: "Senior Credit Officer", size: .medium, color: .white)
                    }
                    .frame(height: 32)
                    Image(.arrowDownIc)
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.horizontal, 25)
        }
        .frame(height: 60)
        .background(Color.navigationBar.edgesIgnoringSafeArea(.top))
    }
    
    var tabbarView: some View {
        VStack {
            VStack {
                ForEach(0..<mainVM.mainTabList.count, id: \.self) { index in
                    TabItemWidget(
                        icon: mainVM.mainTabList[index].icon,
                        title: mainVM.mainTabList[index].title,
                        isSelected: mainVM.tabIndex == index,
                        index: index) {
                            mainVM.tabIndex = index
                        }
                        .padding(.bottom, 20)
                }
            }
            .padding(25)
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .background(Color.tabbar.edgesIgnoringSafeArea(.all))
    }
}
