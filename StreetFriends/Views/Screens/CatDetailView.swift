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
    @State private var showDeleteAlert = false
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
                                mode: .dynamic(maxHeight: 284, fadeProgress: progress),
                                info: .init(name: viewModel.cat.name,
                                            firstMetDateText: "첫만남 : \(viewModel.cat.firstMetDate?.yearMonthKR ?? "미정")"))
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
                                NavigationLink {
                                    CatDetailEditView(cat: viewModel.cat)
                                } label: {
                                    Text("프로필 수정")
                                }
                                
                                Button("프로필 공유") {
                                    
                                }
                                Button("친구 삭제") {
                                    showDeleteAlert = true
                                }
                            } label: {
                                Image(.morePaper)
                            }
                        }
                    }
                )
                .animation(.easeInOut(duration: 0.4), value: isCollapsed)
            }
        } //: ZSTACK
        .overlay {
            if showDeleteAlert {
                CustomAlert(role: .delete(name: viewModel.cat.name),
                            isPresented: $showDeleteAlert) {
                    viewModel.delete(repo: catRepository)
                } rightAction: {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CatDetailView(cat: .previewOne)
    }
}

