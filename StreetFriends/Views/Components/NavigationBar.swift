//
//  NavigationBar.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/26/25.
//

import SwiftUI

struct NavigationBar<LeadingContent: View, TrailingContent: View>: View {
    // MARK: - PROPERTIES
    let title: String
    let leadingContent: LeadingContent
    let trailingContent: TrailingContent
    
    init(title: String,
         @ViewBuilder leading: () -> LeadingContent,
         @ViewBuilder trailing: () -> TrailingContent) {
        self.title = title
        self.leadingContent = leading()
        self.trailingContent = trailing()
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .bottom) {
            Text(title)
                .font(.pretendard(.semiBold, size: 18))
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                leadingContent
                Spacer()
                trailingContent
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, minHeight: 44)
        .background(Color.white)
        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
    }
}

// MARK: - PREVIEW
#Preview("오른쪽에 버튼 하나") {
    NavigationBar(
        title: "친구들",
        leading: {  },
        trailing: { Button { } label: { Image(.addCat) } }
    )
}

#Preview("왼쪽에 버튼 하나") {
    NavigationBar(
        title: "친구들",
        leading: { Button { } label: { Image(.chevronLeft) } },
        trailing: {  }
    )
}

#Preview("오른쪽에 버튼 두개") {
    NavigationBar(
        title: "친구들",
        leading: { Button { } label: { Image(.chevronLeft) } },
        trailing: { HStack { Button { } label: { Image(.selectTrue) }
            Button { } label: { Image(.more) } } }
    )
}
