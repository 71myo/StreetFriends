//
//  HomeView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/25/25.
//

import SwiftUI

struct HomeView: View {
    // MARK: - PROPERTIES
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
        NavigationStack {
            VStack(spacing: 0) {
                NavigationBar(title: "친구들",
                              leading: {},
                              trailing: {
                    HStack(spacing: 12) {
                        Button { isSearching = true } label: { Image(.search) }
                    
                        NavigationLink { AddCatChoiceView() } label: { Image(.addCat) }
                    }
                })
                
                ScrollView {
                    VStack {
                        SectionHeaderView(type: .plain,
                                          title: "가장 자주 만난 친구",
                                          destination: {})
                        .padding(.top, 10)
                        
                        PolaroidCardView(info: .home(catImage: UIImage(resource: .sampleCat),
                                                     catName: "찐빵이",
                                                     recentEncountersCount: 12),
                                         destination: {})
                        .padding(.top, 8)
                        
                        SectionHeaderView(type: .navigation,
                                          title: "즐겨찾는 친구",
                                          destination: {})
                        .padding(.top, 40)
                        
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
                        
                        SectionHeaderView(type: .navigation,
                                          title: "모든 친구",
                                          destination: {})
                        .padding(.top, 40)
                        
                        LazyVGrid(columns: columns, spacing: 4) {
                            ForEach(0..<9) { cat in
                                NavigationLink {
                                    
                                } label: {
                                    CatSquareView(catImage: .sampleCat, type: .favorite(isFavorite: $isCatFavorite))
                                }
                            }
                        } //: GRID
                    } //: VSTACK
                    .padding(.horizontal, 20)
                    .padding(.vertical, 18)
                } //: SCROLL
            } //: VSTACK
            .background(
                Image(.homeBackground)
                    .resizable()
                    .scaledToFill()
            )
        } //: NAVIGATION
        .overlay(alignment: .top) {
            ZStack(alignment: .top) {
                if isSearching {
                    Color.black.opacity(0.3)
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
    }
}
