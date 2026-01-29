//
//  SearchEmptyView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

import SwiftUI

struct SearchEmptyView: View {
    var body: some View {
        VStack(spacing: 26) {
            Image(.mysteryCat)
            
            Text("앗, 찾으시는 친구가 없어요.\n맞춤법을 확인하거나 다시 검색해보세요.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.netural40)
                .font(.pretendard(.medium, size: 18))
        }
        .padding(.top, 120)
    }
}

#Preview {
    SearchEmptyView()
}
