//
//  NavigationBar.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/26/25.
//

import SwiftUI

struct NavigationBar<LeadingContent: View, TrailingContent: View>: View {
    enum Style {
        case solid
        case clear
    }
    
    // MARK: - PROPERTIES
    let title: String
    let style: Style
    let leadingContent: LeadingContent
    let trailingContent: TrailingContent
    
    init(title: String,
         style: Style = .solid,
         titleColor: Color = .netural80,
         @ViewBuilder leading: () -> LeadingContent,
         @ViewBuilder trailing: () -> TrailingContent) {
        self.title = title
        self.style = style
        self.leadingContent = leading()
        self.trailingContent = trailing()
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Text(title)
                .font(.pretendard(.semiBold, size: 18))
                .foregroundStyle(style == .solid ? .netural80 : .white)
            
            HStack {
                leadingContent
                    .foregroundStyle(style == .solid ? .netural80 : .white)
                Spacer()
                trailingContent
                    .foregroundStyle(style == .solid ? .netural80 : .white)
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, minHeight: 44)
        .background(
            Group {
                switch style {
                case .solid:
                    Color.white
                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
                case .clear:
                    Color.clear
                        .shadow(color: .black.opacity(0.0), radius: 0, x: 0, y: 0)
                }
            }
            .ignoresSafeArea(edges: .top)
        )
    }
}

// MARK: - PREVIEW
#Preview("오른쪽에 버튼 하나") {
    NavigationBar(
        title: "친구들",
        leading: {  },
        trailing: { Button { } label: { Image(.addCatData) } }
    )
}

#Preview("왼쪽에 버튼 하나") {
    NavigationBar(
        title: "친구들",
        leading: { Button { } label: { Image(.chevronLeft) } },
        trailing: {  }
    )
}

#Preview("왼쪽에 버튼 하나/Clear Ver") {
    ZStack {
        Color.black
        
        NavigationBar(
            title: "친구들",
            style: .clear,
            leading: { Button { } label: { Image(.chevronLeft) } },
            trailing: {  }
        )
    }
}

#Preview("오른쪽에 버튼 두개") {
    NavigationBar(
        title: "친구들",
        leading: { Button { } label: { Image(.chevronLeft) } },
        trailing: { HStack { Button { } label: { Image(.selectTrue) }
            Button { } label: { Image(.more) } } }
    )
}
