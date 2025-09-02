//
//  CatSelectView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

import SwiftUI

struct CatSelectView: View {
    // MARK: - PROPERTIES
    @Environment(\.catRepository) private var catRepository
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = CatsBrowserViewModel(scope: .both)
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 3)
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                Image(.homeBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.keyboard)
            } //: GEOMETRY
            
            VStack(spacing: 0) {
                NavigationBar(title: "추억쌓기",
                              leading: { Button { dismiss() } label: {Image(.chevronLeft)} },
                              trailing: { Button { viewModel.isSearching = true } label: { Image(.search) } })
                
                ScrollView {
                    
                    // MARK: - 즐겨찾는 친구 섹션
                    VStack(spacing: 12) {
                        SectionHeaderView(type: .navigation,
                                          title: "즐겨찾는 친구",
                                          destination: { FavoriteCatsGridView() })
                        
                        FavoriteCatsHScroll(cats: viewModel.favorites,
                                            onSelect: { cat in /* 디테일뷰 이동 */ },
                                            onToggleFavorite: { cat in viewModel.toggleFavorite(cat: cat, repo: catRepository) })
                    }
                    
                    // MARK: - 모든 친구 섹션
                    VStack(spacing: 12) {
                        SectionHeaderView(type: .navigation,
                                          title: "모든 친구",
                                          destination: { AllCatsGridView() })
                        
                        CatsGridView(cats: viewModel.displayedCats, onSelect: { cat in /* 디테일뷰 이동 */ }, onToggleFavorite: { cat in viewModel.toggleFavorite(cat: cat, repo: catRepository) })
                    }
                    .padding(.top, 40)
                } //: SCROLL
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 12)
            } //: VSTACK
        } //: ZSTACK
        .navigationBarBackButtonHidden()
        .overlay(alignment: .top) {
            CatSearchOverlay(isPresented: $viewModel.isSearching,
                             searchText: $viewModel.searchText,
                             results: viewModel.searchResults) { cat in
                
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.isSearching)
        }
        .task {
            await MainActor.run { viewModel.load(repo: catRepository) }
        }
    }
}

#Preview {
    CatSelectView()
        .environment(\.catRepository, PreviewCatRepository())
}
