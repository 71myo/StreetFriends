//
//  EncounterDetailView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/18/25.
//

import SwiftUI

struct EncounterDetailView: View {
    // MARK: - PROPERTIES
    @Environment(\.catRepository) private var catRepository
    @Environment(\.dismiss) private var dismiss
    @Environment(\.displayScale) private var displayScale
    
    @State private var viewModel: EncounterDetailViewModel
    @State private var showDeleteAlert: Bool = false
    @State private var shareCardWidth: CGFloat = 0

    init(encounterID: UUID) {
        _viewModel = .init(initialValue: EncounterDetailViewModel(encounterID: encounterID))
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            Background()
            
            ScrollView {
                VStack(spacing: 0) {
                    Text(viewModel.dateText)
                        .font(.pretendard(.medium, size: 16))
                        .foregroundStyle(.netural60)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    GeometryReader { geo in
                        DataImage(data: viewModel.photoData, fixedHeight: 335) { img in
                            img
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width, height: 335)
                                .clipped()
                        }
                        .accessibilityLabel("\(viewModel.catName)\(viewModel.catName.waGwa)의 추억 사진")
                    }
                    .frame(height: 335)
                    .padding(.top, 4)
                    
                    Text(viewModel.note)
                        .font(.pretendard(.medium, size: 16))
                        .lineSpacing(4)
                        .foregroundStyle(.netural80)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 16)
                } //: VSTACK
                .padding(.vertical, 24)
                .padding(.horizontal, 20)
            } //: SCROLL
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
            viewModel.load(using: catRepository)
            viewModel.prepareShareCard(scale: displayScale, width: shareCardWidth)
        }
        .safeAreaInset(edge: .top) {
            NavigationBar(title: viewModel.catName,
                          leading: {
                Button {
                    dismiss()
                } label: {
                    Image(.chevronLeft)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .barIconTapArea()
                }
                .barIconAccessibility("뒤로 가기", image: .chevronLeft)
            },
                          trailing: {
                HStack(spacing: 0) {
                    Button {
                        Haptic.favoriteToggled()
                        viewModel.toggleFavorite(using: catRepository)
                    } label: {
                        Image(viewModel.isFavorite ? .selectTrue : .selectFalse)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .barIconTapArea()
                    }
                    .barIconAccessibility("즐겨찾기", systemImage: viewModel.isFavorite ? "heart.fill" : "heart")
                    .accessibilityAddTraits(viewModel.isFavorite ? .isSelected : [])
                    
                    Menu {
                        NavigationLink {
                            EncounterDetailEditView(encounterID: viewModel.id)
                        } label: {
                            Text("추억 수정")
                        }
                        
                        if let item = viewModel.shareItem,
                           let preview = UIImage(data: viewModel.photoData) {
                            ShareLink(item: item,
                                      preview: SharePreview("길에서 만난 소중한 친구 \(viewModel.catName)\(viewModel.catName.waGwa)의 추억이에요 🐾",
                                      image: Image(uiImage: preview))
                            ) { Text("추억 공유") }
                        }
                        
                        Button("추억 삭제") {
                            showDeleteAlert = true
                        }
                    } label: {
                        Image(.more)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .barIconTapArea() 
                    }
                    .barIconAccessibility("더보기", image: .more)
                }
            })
        }
        .overlay {
            if showDeleteAlert {
                CustomAlert(role: .deleteEncounter, isPresented: $showDeleteAlert, leftAction: { viewModel.deleteEncounter(using: catRepository) }, rightAction: { })
            }
        }
        .onChange(of: viewModel.shouldDismiss) { _, go in
            if go {
                dismiss()
                viewModel.shouldDismiss = false
            }
        }
    }
}

#Preview {
    let cat = Cat.previewOne
    let encounter = cat.encounters.first!
    let repo = PreviewCatRepository(cats: [cat])
    
    NavigationStack {
        EncounterDetailView(encounterID: encounter.id)
            .environment(\.catRepository, repo)
    }
}
