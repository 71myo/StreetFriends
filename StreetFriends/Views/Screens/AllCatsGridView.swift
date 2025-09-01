//
//  AllCatsGridView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

import SwiftUI

struct AllCatsGridView: View {
    // MARK: - PROPERTIES
    @Environment(\.catRepository) private var catRepository
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = CatsBrowserViewModel(scope: .all)
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 3)

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
                NavigationBar(title: "모든 친구",
                              leading: { Button { dismiss() } label: {Image(.chevronLeft)} },
                              trailing: { Button { viewModel.isSearching = true } label: { Image(.search) } })
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.displayedCats) { cat in
                            CatSquareView(catImageData: cat.profilePhoto,
                                          type: .favorite(isOn: cat.isFavorite, name: cat.name,
                                                          action: { viewModel.toggleFavorite(cat: cat, repo: catRepository) }))
                        }
                    }
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
    AllCatsGridView()
        .environment(\.catRepository, PreviewCatRepository())
}
