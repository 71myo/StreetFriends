//
//  SearchBar.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/27/25.
//

import SwiftUI

struct SearchBar: View {
    // MARK: - PROPERTIES
    @Binding var searchText: String
    let dismissAction: () -> Void
    
    // MARK: - BODY
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                HStack {
                    Image(.search)
                        .foregroundStyle(.netural40)
                    
                    AppTextField(
                        text: $searchText,
                        placeholder: "친구 검색",
                        autofocus: true,
                        returnKeyType: .search
                    ) { dismissAction() }
                } //: HSTACK(서치 부분)
                .padding(10)
                .frame(height: 44)
                .background(Color.netural10)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Button {
                    searchText = ""
                    dismissAction()
                } label: {
                    Text("취소")
                        .foregroundStyle(.blue50)
                        .font(.pretendard(.regular, size: 18))
                }
            } //: HSTACK
            .padding(.horizontal, 20)
            .padding(.vertical, 6)
        }
        .background(Color.white.ignoresSafeArea(edges: .top)
            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1))
    }
}

#Preview {
    ZStack {
        Color.gray
        SearchBar(searchText: .constant("찐빵이"), dismissAction: {})
    }
}
