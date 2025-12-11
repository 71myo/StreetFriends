//
//  HomeView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/25/25.
//

import SwiftUI

struct HomeView: View {
    // MARK: - PROPERTIES
    @Environment(\.catRepository) private var catRepository
    @Environment(Router.self) private var router
    @State private var viewModel = HomeViewModel()
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Background()
            
            if viewModel.isEmptyState {
                EmptyCatView()
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                        // MARK: - 가장 자주 만난 친구 섹션
                        VStack(spacing: 16) {
                            SectionHeaderView(type: .plain, title: "가장 자주 만난 친구", destination: {})
                            
                            if let cat = viewModel.mostMetCat {
                                PolaroidCardView(info: .home(cat: cat, catImageData: cat.profilePhoto,
                                                             catName: cat.name,
                                                             recentEncountersCount: viewModel.mostMetCount),
                                                 destination: { CatDetailView(cat: cat) })
                            }
                        }
                        
                        // MARK: - 즐겨찾는 친구 섹션
                        VStack(spacing: 12) {
                            SectionHeaderView(type: .navigation,
                                              title: "즐겨찾는 친구",
                                              destination: { FavoriteCatsGridView() })
                            
                            FavoriteCatsHScroll(cats: viewModel.favorites,
                                                destination: { cat in CatDetailView(cat: cat) },
                                                onToggleFavorite: { cat in viewModel.toggleFavorite(cat: cat, repo: catRepository) })
                        }
                        .padding(.top, 40)
                        
                        // MARK: - 모든 친구 섹션
                        VStack(spacing: 12) {
                            SectionHeaderView(type: .navigation,
                                              title: "모든 친구",
                                              destination: { AllCatsGridView() })
                            
                            CatsGridView(cats: viewModel.allCats,
                                         destination: { cat in CatDetailView(cat: cat) },
                                         onToggleFavorite: { cat in viewModel.toggleFavorite(cat: cat, repo: catRepository) })
                        }
                        .padding(.top, 40)
                    } //: 전체 VSTACK
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 12)
                } //: SCROLL
            }
        } //: ZSTACK
        .task {
            await MainActor.run { viewModel.load(repo: catRepository) }
        }
        .safeAreaInset(edge: .top) {
            NavigationBar(title: "친구들",
                          leading: {},
                          trailing: {
                HStack(spacing: 12) {
                    Button { viewModel.isSearching = true } label: { Image(.search) }
                    
                    Button { router.push(.addCatChoice) } label: { Image(.addCatData) }
                }
            })
        }
        .overlay(alignment: .top) {
            CatSearchOverlay(isPresented: $viewModel.isSearching,
                             searchText: $viewModel.searchText,
                             results: viewModel.filteredCats) { cat in
            }.animation(.easeInOut(duration: 0.3), value: viewModel.isSearching)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environment(Router())
    }
    .environment(\.catRepository, PreviewCatRepository())
}
