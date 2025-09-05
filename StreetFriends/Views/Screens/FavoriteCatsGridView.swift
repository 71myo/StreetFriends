//
//  FavoriteCatsGridView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

import SwiftUI

struct FavoriteCatsGridView: View {
    // MARK: - PROPERTIES
    @Environment(\.catRepository) private var catRepository
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = CatsBrowserViewModel(scope: .favorites)
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 3)

    // MARK: - BODY
    var body: some View {
        ZStack {
            Background()
            
            VStack(spacing: 0) {
                NavigationBar(title: "즐겨찾는 친구",
                              leading: { Button { dismiss() } label: {Image(.chevronLeft)} },
                              trailing: { Button { viewModel.isSearching = true } label: { Image(.search) } })
                
                ScrollView {
                    CatsGridView(cats: viewModel.displayedCats,
                                 destination: { cat in CatDetailView(cat: cat) },
                                 onToggleFavorite: { cat in viewModel.toggleFavorite(cat: cat, repo: catRepository)})
                } //: SCROLL
                .padding(.horizontal, 20)
                .padding(.top, 40)
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
    FavoriteCatsGridView()
        .environment(\.catRepository, PreviewCatRepository())
}
