//
//  SectionHeaderView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/27/25.
//

import SwiftUI

enum HeaderType {
    case plain
    case navigation
}

struct SectionHeaderView<Destination: View>: View {
    // MARK: - PROPERTIES
    let type: HeaderType
    let title: String
    
    @ViewBuilder let destination: Destination
    
    // MARK: - BODY
    var body: some View {
        switch type {
        case .plain:
            Text(title)
                .font(.pretendard(.semiBold, size: 18))
                .foregroundStyle(.netural80)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        case .navigation:
            NavigationLink {
                destination
            } label: {
                HStack(spacing: 6) {
                    Text(title)
                        .font(.pretendard(.semiBold, size: 18))
                        .foregroundStyle(.netural80)
                    
                    Image(.chevronRight)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.netural40)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview("PLAIN") {
    SectionHeaderView(type: .plain, title: "가장 자주 만난 친구", destination: {})
}

#Preview("NAVIGATION") {
    SectionHeaderView(type: .navigation, title: "즐겨찾는 친구", destination: {})
}
