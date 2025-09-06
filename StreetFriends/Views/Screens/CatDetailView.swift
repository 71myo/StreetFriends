//
//  CatDetailView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/2/25.
//

import SwiftUI

struct CatDetailView: View {
    // MARK: - PROPERTIES
    @Environment(\.catRepository) private var catRepository
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: CatDetailViewModel
    @State private var headerProgress: CGFloat = 0
    
    private var isCollapsed: Bool { headerProgress >= 0.85 }
    
    init(cat: Cat) {
        _viewModel = State(initialValue: CatDetailViewModel(cat: cat))
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            Background()
            
            ResizableHeaderScrollView(minimumHeight: 110,
                                      maximumHeight: 284,
                                      onProgress: { headerProgress = $0 }
            ) { progress, safeArea in
                // MARK: - HEADER
                CatDetailHeader(imageData: viewModel.cat.profilePhoto,
                                name: viewModel.cat.name,
                                firstMetDateText: "첫만남 : \(viewModel.cat.firstMetDate?.yearMonthKR ?? "미정")",
                                maxHeight: 284,
                                progress: progress)
            } content: {
                // MARK: - CONTENT
                VStack(spacing: 40) {
                    let encounters = viewModel.cat.encounters.sorted { $0.date > $1.date }
                    
                    ForEach(encounters) { encounter in
                        PolaroidCardView(
                            info: .detail(encounter: encounter,
                                          catImageData: encounter.photo,
                                          encounterNote: encounter.note,
                                          encounterDate: encounter.date),
                            destination: {}
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
            } //: RESIZABLE HEADER SCROLLVIEW
            .safeAreaInset(edge: .top) {
                NavigationBar(
                    title: isCollapsed ? viewModel.cat.name : "",
                    style: isCollapsed ? .solid : .clear,
                    leading: { Button { dismiss() } label: { Image(.chevronLeftPaper) } },
                    trailing: {
                        HStack(spacing: 12) {
                            Button {
                                viewModel.togggleFavorite(using: catRepository)
                            } label: {
                                Image(viewModel.cat.isFavorite ? .selectTrue : .selectFalse)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                            
                            Menu {
                                Button("프로필 수정") {
                                    
                                }
                                Button("프로필 공유") {
                                    
                                }
                                Button("친구 삭제") {
                                    
                                }
                            } label: {
                                Image(.morePaper)
                            }
                        }
                    }
                )
                .animation(.easeInOut(duration: 0.4), value: isCollapsed)
            }
        }
    }
}

#Preview {
    CatDetailView(cat: .previewOne)
}

