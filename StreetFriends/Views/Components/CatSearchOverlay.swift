//
//  CatSearchOverlay.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

import SwiftUI

struct CatSearchOverlay: View {
    // MARK: - PROPERTIES
    @Binding var isPresented: Bool /// isSearching
    @Binding var searchText: String
    let results: [Cat] /// searchResults
    
    private var trimmed: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    private var hasQuery: Bool {
        !trimmed.isEmpty
    }
    
    // MARK: - BODY
    var body: some View {
        if isPresented {
            ZStack(alignment: .top) {
                // Dim
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresented = false
                        searchText = ""
                    }
                
                VStack(spacing: 0) {
                    // 상단 검색바
                    SearchBar(searchText: $searchText) { isPresented = false }
                    
                    // 쿼리가 있을 때만 결과/빈뷰 섹션
                    if hasQuery {
                        ZStack(alignment: .top) {
                            Image(.homeBackground)
                                .resizable()
                                .scaledToFill()
                                .ignoresSafeArea(.keyboard)
                            
                            if results.isEmpty {
                                SearchEmptyView()
                                    .transition(.opacity)
                            } else {
                                ScrollView {
                                    VStack(spacing: 0) {
                                        ForEach(results) { cat in
                                            NavigationLink {
                                                CatDetailView(cat: cat)
                                            } label: {
                                                CatSearchRow(cat: cat, query: trimmed)
                                            }
                                        }
                                    }
                                }
                                .transition(.opacity)
                            }
                        }
                    }
                }
                .transition(.move(edge: .top))
            }
        }
    }
}

#Preview {
    CatSearchOverlay(isPresented: .constant(true), searchText: .constant("빵"), results: [.previewOne, .previewTwo])
}
