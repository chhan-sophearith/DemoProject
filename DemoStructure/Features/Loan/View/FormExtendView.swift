//
//  ExtendView.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 22/5/25.
//

import SwiftUI

struct FormExtendView<Content: View>: View {
    let title: String
    let content: Content
    var isExtend: Bool = false
    
    init(title: String, isExtend: Bool, @ViewBuilder content: () -> Content) {
        self.title = title
        self.isExtend = isExtend
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(16)
            VStack {
                HStack {
                    HStack {
                        Image(.defaultCheckIc)
                            .resizable()
                            .frame(width: 28, height: 28)
                        TextSwiftUI(title: title, size: .large, weight: .bold)
                            .padding(.leading, 10)
                    }
                    
                    Spacer()
                    
                    Image(isExtend ? .extendArrowUp : .extendArrowDown)
                        .frame(width: 28, height: 28)
                }
                .padding(.horizontal, 25)
                .padding(.top, 25)
                .padding(.bottom, isExtend ? 0 : 25)
                content
                    .cornerRadius(16)
                    .padding(.bottom, 10)
            }
        }
    }
}
