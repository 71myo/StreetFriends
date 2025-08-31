//
//  HomeView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/25/25.
//

import SwiftUI

struct HomeView: View {
    // MARK: - PROPERTIES
    @Environment(Router.self) private var router
    @State private var searchText: String = ""
    @State private var isCatFavorite: Bool = false
    @State private var isSearching: Bool = false
    
    let columns = [
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4)
    ]
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Image(.homeBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.keyboard)
            } //: GEOMETRY
            
            VStack(spacing: 0) {
                NavigationBar(title: "친구들",
                              leading: {},
                              trailing: {
                    HStack(spacing: 12) {
                        Button { isSearching = true } label: { Image(.search) }
                        
                        Button { router.push(.addCatChoice) } label: { Image(.addCatData) }
                    }
                })
                
                ScrollView {
                    VStack(spacing: 0) {
                        // MARK: - 가장 자주 만난 친구 섹션
                        VStack(spacing: 16) {
                            SectionHeaderView(type: .plain, title: "가장 자주 만난 친구", destination: {})
                            
                            
                            PolaroidCardView(info: .home(catImage: UIImage(resource: .sampleCat),
                                                         catName: "찐빵이",
                                                         recentEncountersCount: 12),
                                             destination: {})
                            
                        }
                        
                        // MARK: - 즐겨찾는 친구 섹션
                        VStack(spacing: 12) {
                            SectionHeaderView(type: .navigation,
                                              title: "즐겨찾는 친구",
                                              destination: {})
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(0..<9) { cat in
                                        NavigationLink {
                                            
                                        } label: {
                                            CatSquareView(catImage: .sampleCat, type: .favorite(isFavorite: $isCatFavorite))
                                                .frame(height: 130)
                                        }
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                        }
                        .padding(.top, 40)
                        
                        // MARK: - 모든 친구 섹션
                        VStack(spacing: 12) {
                            SectionHeaderView(type: .navigation,
                                              title: "모든 친구",
                                              destination: {})
                            
                            LazyVGrid(columns: columns, spacing: 4) {
                                ForEach(0..<9) { cat in
                                    NavigationLink {
                                        
                                    } label: {
                                        CatSquareView(catImage: .sampleCat, type: .favorite(isFavorite: $isCatFavorite))
                                    }
                                }
                            } //: GRID
                        }
                        .padding(.top, 40)
                    } //: 전체 VSTACK
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 12)
                } //: SCROLL
            } //: VSTACK
        } //: ZSTACK
        .overlay(alignment: .top) {
            ZStack(alignment: .top) {
                if isSearching {
                    Color.black.opacity(0.2)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isSearching = false
                            searchText = ""
                        }
                    
                    SearchBar(searchText: $searchText) {
                        isSearching = false
                    }
                    .transition(.move(edge: .top))
                }
            }
            .animation(.easeInOut(duration: 0.3), value: isSearching)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environment(Router())
    }
}
