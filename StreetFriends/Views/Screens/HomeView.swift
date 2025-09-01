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
            GeometryReader { _ in
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
                        Button { viewModel.isSearching = true } label: { Image(.search) }
                        
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
                                              destination: { FavoriteCatsGridView() })
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(viewModel.favorites) { cat in
                                        NavigationLink {
                                            Text(cat.name)
                                        } label: {
                                            CatSquareView(
                                                catImageData: cat.profilePhoto,
                                                type: .favorite(
                                                    isOn: cat.isFavorite,
                                                    name: cat.name,
                                                    action: { viewModel.toggleFavorite(cat: cat, repo: catRepository) }
                                                )
                                            )
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
                                              destination: { AllCatsGridView() })
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 3),
                                      spacing: 4) {
                                ForEach(viewModel.allCats) { cat in
                                    NavigationLink {
                                        Text(cat.name)
                                    } label: {
                                        CatSquareView(
                                            catImageData: cat.profilePhoto,
                                            type: .favorite(
                                                isOn: cat.isFavorite,
                                                name: cat.name,
                                                action: { viewModel.toggleFavorite(cat: cat, repo: catRepository) }
                                            )
                                        )
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
            CatSearchOverlay(isPresented: $viewModel.isSearching,
                             searchText: $viewModel.searchText,
                             results: viewModel.filteredCats) { cat in
                
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.isSearching)
        }
        .task {
            await MainActor.run { viewModel.load(repo: catRepository) }
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
