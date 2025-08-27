//
//  SearchBar.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/27/25.
//

import SwiftUI

struct SearchBar: View {
    // MARK: - PROPERTY
    @Binding var searchText: String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Image(.search)
                .foregroundStyle(.netural40)
            
            TextField("친구 검색", text: $searchText)
                .foregroundStyle(.netural80)
                .tint(.green60)
            
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.green60)
                }
            }
        } //: HSTACK
        .padding(10)
        .frame(height: 44)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
    }
}

#Preview {
    ZStack {
        Color.gray
        SearchBar(searchText: .constant("찐빵이"))
    }
}
