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
    @Environment(\.displayScale) private var displayScale

    @State private var viewModel: CatDetailViewModel
    @State private var showDeleteAlert = false
    @State private var headerProgress: CGFloat = 0
    @State private var shareCardWidth: CGFloat = 0
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
                                mode: .dynamic(maxHeight: 284, fadeProgress: progress),
                                info: .init(name: viewModel.cat.name,
                                            firstMetDate: viewModel.cat.firstMetDate?.yearMonthKR ?? "미정"))
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
                            destination: {
                                EncounterDetailView(encounterID: encounter.id)
                            }
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
            } //: RESIZABLE HEADER SCROLLVIEW
        } //: ZSTACK
        .background {
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        shareCardWidth = max(0, proxy.size.width - 40)
                    }
                    .onChange(of: proxy.size.width) { _, newWidth in
                        shareCardWidth = max(0, newWidth - 40)
                    }
            }
        }
        .task(id: shareCardWidth) {
            guard shareCardWidth > 0 else { return }
            viewModel.prepareShareCard(scale: displayScale, width: shareCardWidth)
        }
        .safeAreaInset(edge: .top) {
            NavigationBar(
                title: isCollapsed ? viewModel.cat.name : "",
                style: isCollapsed ? .solid : .clear,
                leading: {
                    Button { dismiss() }
                    label: { Image(.chevronLeftPaper).barIconTapArea()  }
                        .barIconAccessibility("뒤로 가기", image: .chevronLeft)
                },
                trailing: {
                    HStack(spacing: 0) {
                        Button {
                            Haptic.favoriteToggled()
                            viewModel.togggleFavorite(using: catRepository)
                        } label: {
                            Image(viewModel.cat.isFavorite ? .selectTrue : .selectFalse)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .barIconTapArea()
                        }
                        .barIconAccessibility("즐겨찾기", systemImage: viewModel.cat.isFavorite ? "heart.fill" : "heart")
                        .accessibilityAddTraits(viewModel.cat.isFavorite ? .isSelected : [])
                        Menu {
                            NavigationLink {
                                CatDetailEditView(cat: viewModel.cat)
                            } label: {
                                Text("친구 수정")
                            }
                            
                            if let item = viewModel.shareItem,
                               let data = viewModel.cat.profilePhoto,
                               let preview = UIImage(data: data) {
                                ShareLink(item: item,
                                          message: Text("귀여운 친구 \(viewModel.cat.name)\(viewModel.cat.name.eulReul) 소개할게요!"),
                                          preview: SharePreview("🐾 \(viewModel.cat.name) 🐾", image: Image(uiImage: preview))
                                ) { Text("친구 공유") }
                            }
                            
                            Button("친구 삭제") {
                                showDeleteAlert = true
                            }
                        } label: {
                            Image(.morePaper)
                                .barIconTapArea() 
                        }
                        .barIconAccessibility("더보기", image: .more)
                    }
                }
            )
            .animation(.easeInOut(duration: 0.4), value: isCollapsed)
        }
        .overlay {
            if showDeleteAlert {
                CustomAlert(role: .delete(name: viewModel.cat.name),
                            isPresented: $showDeleteAlert) {
                    viewModel.delete(repo: catRepository)
                    dismiss()
                } rightAction: { }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CatDetailView(cat: .previewOne)
    }
}

