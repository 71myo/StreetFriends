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
                // 콘텐츠 VSTACK
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
                        }
                        .frame(width: geo.size.width, height: 335)
                        .padding(.top, 4)
                    }
                    .frame(height: 335)
                    
                    Text(viewModel.note)
                        .font(.pretendard(.medium, size: 16))
                        .lineSpacing(4)
                        .foregroundStyle(.netural80)
                        .padding(.top, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } //: VSTACK
            } //: SCROLL
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
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
                }
            },
                          trailing: {
                HStack(spacing: 4) {
                    Button {
                        viewModel.toggleFavorite(using: catRepository)
                    } label: {
                        Image(viewModel.isFavorite ? .selectTrue : .selectFalse)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    
                    Menu {
                        NavigationLink {
                            EncounterDetailEditView(encounterID: viewModel.id)
                        } label: {
                            Text("추억 수정")
                        }
                        
                        if let item = viewModel.shareItem,
                           let preview = viewModel.sharePreviewImage {
                            ShareLink(item: item,
                                      preview: SharePreview("\(viewModel.catName) 추억",
                                                            image: Image(uiImage: preview))
                            ) { Text("추억 공유") }
                        }
                        
                        Button("삭제하기") {
                            showDeleteAlert = true
                        }
                    } label: {
                        Image(.more)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
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
