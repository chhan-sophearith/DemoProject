//
//  TabItemWidget.swift
//  DemoStructure
//
//  Created by Chhan Sophearith  on 20/5/25.
//

import SwiftUI

struct TabItemWidget: View {
    var icon: ImageResource
    var title: String
    var isSelected: Bool
    var index: Int
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                if isSelected {
                    ZStack {
                        Rectangle()
                            .fill(Color.commonGreen)
                            .cornerRadius(16)
                            .frame(width: 48, height: 48)
                        Image(icon)
                            .resizable()
                            .foregroundColor(isSelected ? .blue : .gray)
                            .frame(width: 24, height: 24)
                    }
                    TextSwiftUI(title: title, color: Color.white)
                    Rectangle()
                        .fill(Color.commonGreen)
                        .frame(width: 48, height: 5)
                } else {
                    Image(icon)
                        .resizable()
                        .foregroundColor(isSelected ? .blue : .gray)
                        .frame(width: 24, height: 24)
                    TextSwiftUI(title: title, color: Color.white)
                }
            }
        }
    }
}
