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
    @FocusState private var isFocused: Bool
    
    // MARK: - BODY
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                HStack {
                    Image(.search)
                        .foregroundStyle(.netural40)
                    
                    TextField("친구 검색", text: $searchText)
                        .foregroundStyle(.netural80)
                        .font(.pretendard(.regular, size: 18))
                        .tint(.blue50)
                        .focused($isFocused)
                    
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.blue50)
                        }
                    }
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
        .onAppear {
            isFocused = true
        }
        
    }
}

#Preview {
    ZStack {
        Color.gray
        SearchBar(searchText: .constant("찐빵이"), dismissAction: {})
    }
}
